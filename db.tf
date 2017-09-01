# rancher (cattle) database
resource "aws_db_subnet_group" "db" {
  subnet_ids = ["${aws_subnet.db_1.id}", "${aws_subnet.db_2.id}"]
}

resource "aws_db_instance" "rancher" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mariadb"
  instance_class       = "db.t2.small"
  name                 = "cattle"
  username             = "cattle"
  password             = "${var.db_password}"
  db_subnet_group_name = "${aws_db_subnet_group.db.name}"
  skip_final_snapshot  = "true"
  parameter_group_name = "${aws_db_parameter_group.rancher.name}"
}

resource "aws_db_parameter_group" "rancher" {
  family = "mariadb10.0"

  parameter {
    name  = "innodb_file_format"
    value = "Barracuda"
  }

  parameter {
    name  = "max_connections"
    value = "200"
  }

  parameter {
    name  = "max_allowed_packet"
    value = "16777216"
  }
}
