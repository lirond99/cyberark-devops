data "aws_availability_zones" "available" {
  state = "available"
}


module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-${var.app_environment}"
  cidr = var.vpc_cidr

  azs             = [data.aws_availability_zones.available.names[0], 
                     data.aws_availability_zones.available.names[1],
                     data.aws_availability_zones.available.names[2]]
  private_subnets = [var.private_subnet_cidr]
  public_subnets  = [var.public_subnet_cidr1, var.public_subnet_cidr2]

  enable_nat_gateway = true

  tags = {
    Terraform = "true"
    Environment = "vpc-${var.app_environment}"
  }
}


module "elb_http" {
  source  = "terraform-aws-modules/elb/aws"
  version = "~> 2.0"

  name = "elb-${var.app_environment}"

  subnets         = [module.vpc.public_subnets[0], module.vpc.public_subnets[1]]
  security_groups = [aws_security_group.aws-elb-sg.id]
  internal        = false

  listener = [
    {
      instance_port     = 80
      instance_protocol = "HTTP"
      lb_port           = 80
      lb_protocol       = "HTTP"
    }
  ]

  health_check = {
    target              = "HTTP:80/"
    interval            = 300
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }

  number_of_instances = var.instance_count
  instances           = split(",","${join(",", aws_instance.linux-server.*.id)}")

  tags = {
    Environment = "elb-${var.app_environment}"
  }
}