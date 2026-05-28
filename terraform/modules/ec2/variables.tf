variable "environment" {}
variable "subnet_id" {}
variable "security_group_id" {}
variable "public_key_path" {}
variable "ami_id" {}
variable "servers" {
  type = map(string)
}