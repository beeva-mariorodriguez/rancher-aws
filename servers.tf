# rancher server(s)
resource "aws_instance" "rancher_server" {
  ami           = "${data.aws_ami.rancher_server.image_id}"
  instance_type = "${var.rancher_server_size}"
  subnet_id     = "${aws_subnet.servers.id}"
  depends_on    = ["aws_internet_gateway.gw", "aws_route.r"]
  key_name      = "${var.aws_key_name}"

  vpc_security_group_ids = [
    "${aws_vpc.cluster.default_security_group_id}",
    "${aws_security_group.rancher_server.id}",
  ]

  provisioner "remote-exec" {
    # run rancher server container, wait a bit and configure API endpoint
    # no curl on rancherOS by default, so we use the one installed in the rancher/server image
    inline = [
      "#!/bin/bash",
      "docker run -d --restart=unless-stopped -p 8088:8088 -p 8080:8080 -p 9345:9345 rancher/server:${var.rancher_server_version} --db-host ${aws_db_instance.rancher.address} --db-port ${aws_db_instance.rancher.port} --db-user ${aws_db_instance.rancher.username} --db-pass ${var.db_password} --db-name cattle --advertise-address ${self.private_ip}",
      "sleep 60",
      "docker run --rm rancher/server:${var.rancher_server_version} curl -XPUT -d '{\"value\":\"http://lb.${var.domain_name}:8080\"}' -H 'Content-Type: application/json' http://${self.private_ip}:8080/v1/settings/api.host",
    ]

    connection {
      type = "ssh"
      user = "rancher"
    }
  }

  count = 1
}
