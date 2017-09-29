resource "aws_elb" "lb" {
  internal = true
  subnets  = ["${aws_subnet.servers.id}"]

  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 8080
    lb_protocol       = "http"
  }

  instances = ["${aws_instance.rancher_server.*.id}"]
}
