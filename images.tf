# AMI images 
data "aws_ami" "rancher_server" {
  most_recent = true

  filter {
    name   = "owner-id"
    values = ["605812595337"]
  }

  filter {
    name   = "name"
    values = ["rancheros-*hvm*"]
  }
}

data "aws_ami" "rancheros" {
  most_recent = true

  filter {
    name   = "owner-id"
    values = ["605812595337"]
  }

  filter {
    name   = "name"
    values = ["rancheros-*hvm*"]
  }
}
