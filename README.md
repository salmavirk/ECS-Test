# ECS-Test

This is designed for Terraform v0.12 (or later)

## Notes:

This creates a VPC with 3 public subnets, specifying the region.

This also sets up an auto-scaling group of 1 Ubuntu instance possibly autoscaling it to 3.

## SSH Access
To SSH onto your instance you will need to generate your own key

```ssh-keygen -f terraform_ec2_key```

Keep the private ket a secret. Alternatively you are able to connect to the instance via
EC2 instance connect through the console.

## Security Groups
1 - A security group is created and attached to the instance. This allows SSH access
and all egress traffic.
2 - Another security group is created for the elastic load balancer which allows all traffic in from port
    8080.

## How to run the terraform

```bash
terraform apply --var assign_public_ipv4=true --var aws_region=eu-west-1
```
This is assuming you would like the region eu-west-1. Other's can be selected.

## HTML Page
To see Brett's amazing pictures, copy the elb_dns_name from the output and append
the port 8080 to it.

## Improvements
Next stage could be to move the EC2 instances into a private subnet attaching a NAT
gateway to the public subnet. Taking off a public IP addresses for the instances and
allowing SSH access soley via SSM. This would an SSM role attached to the instances.

