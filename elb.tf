resource "aws_elb" "website_lb" {
  name = "terraform-elb-website"
  internal           = false
  security_groups = ["${aws_security_group.elb.id}"]
  subnets = ["${aws_subnet.ecs_subnet_a.id}", "${aws_subnet.ecs_subnet_b.id}", "${aws_subnet.ecs_subnet_c.id}"]
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 300 #30
    target = "HTTP:80/"
  }
  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "80"
    instance_protocol = "http"
  }
}