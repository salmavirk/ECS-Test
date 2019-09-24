resource "aws_launch_configuration" "example-launchconfig" {
  name_prefix = "example-launchconfig"
  image_id = "${lookup(var.ami_map, var.aws_region)}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.terraform_ec2_key.key_name}"
  security_groups = ["${aws_security_group.allow-ssh.id}"]
}

resource "aws_key_pair" "terraform_ec2_key" {
  key_name = "terraform_ec2_key"
  public_key = "${file("terraform_ec2_key.pub")}"
}
resource "aws_autoscaling_group" "example-autoscaling" {
  name = "example-autoscaling"
  vpc_zone_identifier = ["${aws_subnet.ecs_subnet_a.id}", "${aws_subnet.ecs_subnet_b.id}"]
  launch_configuration = "${aws_launch_configuration.example-launchconfig.name}"
  min_size = 1
  max_size = 2
  health_check_grace_period = 300
  health_check_type = "EC2"
  force_delete = true

  tag {
    key = "Name"
    value = "ec2 instance"
    propagate_at_launch = true
  }
}