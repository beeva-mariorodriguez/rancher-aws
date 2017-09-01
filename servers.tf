# rancher server(s)
resource "aws_instance" "rancher_server" {
  ami           = "${data.aws_ami.rancher_server.image_id}"
  instance_type = "${var.rancher_server_size}"

  subnet_id  = "${aws_subnet.servers.id}"
  depends_on = ["aws_internet_gateway.gw", "aws_route53_zone.private", "aws_route.r"]
  key_name   = "${var.aws_key_name}"

  vpc_security_group_ids = [
    "${aws_vpc.cluster.default_security_group_id}",
    "${aws_security_group.rancher.id}",
    "${aws_security_group.rancher_server.id}",
    "${aws_security_group.allow_ssh.id}",
    "${aws_security_group.allow_outbound.id}",
  ]

  provisioner "remote-exec" {
    inline = [
      "docker run -d --restart=unless-stopped -p 8088:8088 -p 8080:8080 -p 9345:9345 rancher/server:${var.rancher_server_version} --db-host ${aws_db_instance.rancher.address} --db-port ${aws_db_instance.rancher.port} --db-user ${aws_db_instance.rancher.username} --db-pass ${var.db_password} --db-name cattle --advertise-address ${self.private_ip}",
    ]

    connection {
      type = "ssh"
      user = "rancher"
    }
  }

  count = 1
}
