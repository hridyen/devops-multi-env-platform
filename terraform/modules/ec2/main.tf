resource "aws_key_pair" "deployer" {
  key_name   = "${var.environment}-key"
  public_key = file(var.public_key_path)
}

resource "aws_instance" "servers" {
  for_each = var.servers

  ami                         = var.ami_id
  instance_type               = each.value
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.deployer.key_name

  tags = {
    Name = "${var.environment}-${each.key}"
  }
}