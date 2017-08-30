# private dns
resource "aws_route53_zone" "private" {
  name          = "${var.domain_name}"
  force_destroy = true
  vpc_id        = "${aws_vpc.cluster.id}"
}

resource "aws_route53_record" "rancher" {
  zone_id = "${aws_route53_zone.private.zone_id}"
  name    = "rancher"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.rancher_server.private_ip}"]
}
