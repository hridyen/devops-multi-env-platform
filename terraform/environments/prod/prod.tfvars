aws_region         = "ap-south-1"
environment        = "prod"
vpc_cidr           = "10.1.0.0/16"
public_subnet_cidr = "10.1.1.0/24"
instance_type      = "t2.micro"

servers = {
  app = "t2.micro"
}