variable "domain_name" {
  type    = "string"
  default = "rancher.cluster"
}

variable "aws_region" {
  type    = "string"
  default = "us-east-2"
}

variable "aws_cidr_block" {
  type    = "string"
  default = "10.20.0.0/16"
}

variable "aws_servers_cidr_block" {
  type    = "string"
  default = "10.20.0.0/24"
}

variable "aws_db_cidr_block_1" {
  type    = "string"
  default = "10.20.1.0/24"
}

variable "aws_db_az_1" {
  type    = "string"
  default = "us-east-2a"
}

variable "aws_db_cidr_block_2" {
  type    = "string"
  default = "10.20.2.0/24"
}

variable "aws_db_az_2" {
  type    = "string"
  default = "us-east-2b"
}

variable "rancher_server_hosts" {
  type    = "string"
  default = 1
}

variable "aws_key_name" {
  type = "string"
}

variable "rancher_server_size" {
  type    = "string"
  default = "t2.medium"
}

variable "rancher_server_version" {
  type    = "string"
  default = "stable"
}

variable "db_password" {
  type    = "string"
  default = "cattlecattle"
}
