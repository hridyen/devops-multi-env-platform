aws_region         = "ap-south-1"
environment        = "dev"
vpc_cidr           = "10.0.0.0/16"
public_subnet_cidr = "10.0.1.0/24"
instance_type      = "t2.micro"
public_key_path    = "~/.ssh/id_rsa.pub"

ami_id = "ami-07a00cf47dbbc844c"

servers = {
  jenkins = "t2.micro"
  app     = "t2.micro"
}