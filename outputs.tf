output "elb_dns_name" {
  value = "${aws_elb.website_lb.dns_name}"
}
