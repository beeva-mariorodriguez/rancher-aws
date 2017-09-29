# private dns
resource "aws_route53_zone" "private" {
  name          = "${var.domain_name}"
  force_destroy = true
  vpc_id        = "${aws_vpc.cluster.id}"
}

resource "aws_route53_record" "server" {
  zone_id = "${aws_route53_zone.private.zone_id}"
  name    = "server"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.rancher_server.*.private_ip}"]
}

resource "aws_route53_record" "lb" {
  zone_id = "${aws_route53_zone.private.zone_id}"
  name    = "lb"
  type    = "A"

  alias {
    name                   = "${aws_elb.lb.dns_name}"
    zone_id                = "${aws_elb.lb.zone_id}"
    evaluate_target_health = false
  }
}
