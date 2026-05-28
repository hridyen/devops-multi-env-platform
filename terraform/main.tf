module "network" {
  source = "./modules/network"

  environment        = var.environment
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
}

module "security" {
  source = "./modules/security"

  environment = var.environment
  vpc_id      = module.network.vpc_id
}

module "ec2" {
  source = "./modules/ec2"

  environment       = var.environment
  subnet_id         = module.network.public_subnet_id
  security_group_id = module.security.security_group_id
  public_key_path   = var.public_key_path
  ami_id            = var.ami_id
  servers           = var.servers
}