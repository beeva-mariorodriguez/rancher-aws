# vpc, subnets, gateway and (internet) route
resource "aws_vpc" "cluster" {
  cidr_block           = "${var.aws_cidr_block}"
  enable_dns_hostnames = true
}

resource "aws_subnet" "servers" {
  vpc_id                  = "${aws_vpc.cluster.id}"
  cidr_block              = "${var.aws_servers_cidr_block}"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "db_1" {
  vpc_id                  = "${aws_vpc.cluster.id}"
  cidr_block              = "${var.aws_db_cidr_block_1}"
  availability_zone       = "${var.aws_db_az_1}"
  map_public_ip_on_launch = false
}

resource "aws_subnet" "db_2" {
  vpc_id                  = "${aws_vpc.cluster.id}"
  cidr_block              = "${var.aws_db_cidr_block_2}"
  availability_zone       = "${var.aws_db_az_2}"
  map_public_ip_on_launch = false
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.cluster.id}"
}

resource "aws_route" "r" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = "${aws_vpc.cluster.default_route_table_id}"
  gateway_id             = "${aws_internet_gateway.gw.id}"
}
