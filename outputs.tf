output "domain_name" {
  value = "${var.domain_name}"
}

output "dns_zone_id" {
  value = "${aws_route53_zone.private.id}"
}

output "vpc_id" {
  value = "${aws_vpc.cluster.id}"
}

output "bastion_public_ip" {
  value = "${aws_instance.bastion.public_ip}"
}
