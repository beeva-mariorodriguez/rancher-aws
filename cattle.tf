resource "rancher_environment" "cattle" {
  name          = "cattle"
  orchestration = "cattle"
}

resource "rancher_registration_token" "cattle" {
  name           = "cattle_environment_token"
  description    = "Registration token for the cattle environment"
  environment_id = "${rancher_environment.cattle.id}"
}

resource "aws_instance" "cattle_host" {
  ami           = "${data.aws_ami.rancheros.image_id}"
  instance_type = "${var.rancher_host_size}"
  subnet_id     = "${aws_subnet.hosts.id}"
  depends_on    = ["aws_internet_gateway.gw", "aws_route53_zone.private", "aws_instance.rancher_server"]
  key_name      = "${var.aws_key_name}"

  vpc_security_group_ids = [
    "${aws_security_group.rancher.id}",
    "${aws_security_group.rancher_host.id}",
    "${aws_security_group.allow_ssh.id}",
    "${aws_security_group.allow_outbound.id}",
  ]

  count = 4

  provisioner "remote-exec" {
    inline = [
      "docker run -d --privileged -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/rancher:/var/lib/rancher rancher/agent:${var.rancher_agent_version} ${rancher_registration_token.cattle.registration_url}",
    ]

    connection {
      type = "ssh"
      user = "rancher"
    }
  }
}
