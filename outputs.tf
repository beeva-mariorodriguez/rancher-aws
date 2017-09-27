output "hosts_subnet" {
  value = "${aws_subnet.hosts.id}"
}

output "hosts_sc" {
  value = "${aws_security_group.rancher_host.id}"
}

output "key" {
  value = "${var.aws_key_name}"
}

output "bastion_public_ip" {
  value = "${aws_instance.bastion.public_ip}"
}
