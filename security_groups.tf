# security groups
# resource "aws_security_group" "allow_outbound" {
#   vpc_id      = "${aws_vpc.cluster.id}"
#   name        = "allow_outbound"
#   description = "allow all outbound"

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

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
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    self            = true
    security_groups = ["${aws_security_group.rancher_host.id}"]
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
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${aws_security_group.bastion.id}"]
  }
}

resource "aws_security_group" "rancher_host" {
  vpc_id      = "${aws_vpc.cluster.id}"
  name        = "rancher_host"
  description = "rancher_host"

  # IPSec
  ingress {
    from_port = 500
    to_port   = 500
    protocol  = "udp"
    self      = true
  }

  # IPSec
  ingress {
    from_port = 4500
    to_port   = 4500
    protocol  = "udp"
    self      = true
  }

  # VXLAN
  ingress {
    from_port = 4789
    to_port   = 4789
    protocol  = "udp"
    self      = true
  }

  # ssh
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${aws_security_group.bastion.id}"]
  }
}
