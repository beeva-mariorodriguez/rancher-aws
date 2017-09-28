# security groups
resource "aws_security_group" "bastion" {
  vpc_id      = "${aws_vpc.cluster.id}"
  name        = "bastion"
  description = "bastion"

  # ssh
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "rancher_server" {
  vpc_id      = "${aws_vpc.cluster.id}"
  name        = "rancher_server"
  description = "rancher_server"

  # rancher API
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    self        = true
    cidr_blocks = ["${var.aws_cidr_block}"] # access from VPC
  }

  # rancher server HA
  ingress {
    from_port = 9345
    to_port   = 9345
    protocol  = "tcp"
    self      = true
  }

  # ssh
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
