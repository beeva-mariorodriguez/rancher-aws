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
  password             = "Thiephi8enaile8w"
  db_subnet_group_name = "${aws_db_subnet_group.db.name}"
  skip_final_snapshot  = "true"
}
