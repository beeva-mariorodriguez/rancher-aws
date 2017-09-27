# bastion
resource "aws_instance" "bastion" {
  ami           = "${data.aws_ami.rancher_server.image_id}"
  instance_type = "${var.rancher_server_size}"

  subnet_id  = "${aws_subnet.servers.id}"
  depends_on = ["aws_internet_gateway.gw", "aws_route.r"]
  key_name   = "${var.aws_key_name}"

  vpc_security_group_ids = [
    "${aws_vpc.cluster.default_security_group_id}",
    "${aws_security_group.bastion.id}",
  ]

  count = 1
}
