resource "aws_launch_configuration" "website_launchconfig" {
  name_prefix                 = "website-launchconfig"
  associate_public_ip_address = true
  image_id                    = "${lookup(var.ami_map, var.aws_region)}"
  instance_type               = "t2.micro"
  user_data                   = "${file("user-data.sh")}"
  key_name                    = "${aws_key_pair.terraform_ec2_key.key_name}"
  security_groups             = ["${aws_security_group.website_allow_ssh.id}"]
}

resource "aws_key_pair" "terraform_ec2_key" {
  key_name   = "terraform_ec2_key"
  public_key = "${file("terraform_ec2_key.pub")}"
}

resource "aws_autoscaling_group" "website_autoscaling" {
  name                      = "website-autoscaling"
  vpc_zone_identifier       = ["${aws_subnet.ecs_subnet_a.id}", "${aws_subnet.ecs_subnet_b.id}", "${aws_subnet.ecs_subnet_c.id}"]
  launch_configuration      = "${aws_launch_configuration.website_launchconfig.name}"
  min_size                  = 1
  max_size                  = 3
  health_check_grace_period = 300
  load_balancers            = ["${aws_elb.website_lb.name}"]
  health_check_type         = "EC2"
  force_delete = true

  tags                      = [
    {
      key                   = "Name"
      value                 = "website instance"
      propagate_at_launch   = true
    },
    {
      key                   = "terraform"
      value                 = "true"
      propagate_at_launch   = true
    },
  ]
}
