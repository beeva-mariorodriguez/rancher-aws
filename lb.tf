resource "aws_elb" "lb" {
  internal = true
  subnets  = ["${aws_subnet.servers.id}"]

  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 8080
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8080/health"
    interval            = 30
  }

  instances = ["${aws_instance.rancher_server.*.id}"]
}
