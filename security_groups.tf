# security groups
resource "aws_security_group" "allow_outbound" {
  vpc_id      = "${aws_vpc.cluster.id}"
  name        = "allow_outbound"
  description = "allow all outbound"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "rancher" {
  vpc_id      = "${aws_vpc.cluster.id}"
  name        = "rancher"
  description = "rancher"
}

resource "aws_security_group" "rancher_server" {
  vpc_id      = "${aws_vpc.cluster.id}"
  name        = "rancher_server"
  description = "rancher_server"

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    self            = true
    security_groups = ["${aws_security_group.rancher.id}"]
  }

  ingress {
    from_port = 9345
    to_port   = 9345
    protocol  = "tcp"
    self      = true
  }
}

resource "aws_security_group" "rancher_host" {
  vpc_id      = "${aws_vpc.cluster.id}"
  name        = "rancher_host"
  description = "rancher_host"

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    self            = true
    security_groups = ["${aws_security_group.rancher.id}"]
  }
}

resource "aws_security_group" "allow_ssh" {
  vpc_id      = "${aws_vpc.cluster.id}"
  name        = "allow_ssh"
  description = "allow_ssh"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
