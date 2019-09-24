# ECS-Test

This is designed for Terraform v0.12 (or later)

## Notes:

This creates a VPC  with 3 public subnets, specifying the region.

This also sets up an auto-scaling group of Ubuntu instances, and some IAM roles
to support them to use SSM instead of SSH if required.

A security group is created and attached to the instance. This allows SSH access
and egress traffic.

```bash
terraform apply --var assign_public_ipv4=true --var aws_region=eu-west-1
```

To get best use of this, put your public SSH key instead of the example one
named `example_ssh_key`.
