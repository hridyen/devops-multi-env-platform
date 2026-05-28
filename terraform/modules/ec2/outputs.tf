output "instance_public_ips" {
  value = {
    for name, instance in aws_instance.servers :
    name => instance.public_ip
  }
}