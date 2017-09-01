resource "rancher_environment" "mesos" {
  name          = "mesos"
  orchestration = "mesos"
}

resource "rancher_registration_token" "mesos" {
  name           = "mesos_environment_token"
  description    = "Registration token for the mesos environment"
  environment_id = "${rancher_environment.mesos.id}"

  # host_labels {
  #   orchestration = true
  #   etcd          = true
  #   compute       = true
  # }
}

resource "aws_instance" "mesos_host" {
  ami           = "${data.aws_ami.rancheros.image_id}"
  instance_type = "${var.rancher_host_size}"
  subnet_id     = "${aws_subnet.hosts.id}"
  depends_on    = ["aws_internet_gateway.gw", "aws_route53_zone.private"]
  key_name      = "${var.aws_key_name}"

  vpc_security_group_ids = [
    "${aws_security_group.rancher.id}",
    "${aws_security_group.rancher_host.id}",
    "${aws_security_group.allow_ssh.id}",
    "${aws_security_group.allow_outbound.id}",
  ]

  count = 0

  provisioner "remote-exec" {
    inline = [
      "docker run -d --privileged -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/rancher:/var/lib/rancher rancher/agent:${var.rancher_agent_version} ${rancher_registration_token.mesos.registration_url}",
    ]

    connection {
      type = "ssh"
      user = "rancher"
    }
  }
}
