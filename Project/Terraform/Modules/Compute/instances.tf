resource "aws_instance" "bastion-server" {
  ami           = "ami-0a7d80731ae1b2435"
  instance_type = "t3.micro"

  associate_public_ip_address = true
  security_groups             = [var.compute-workloads.bastion-server.sg-id]
  subnet_id                   = var.compute-workloads.bastion-server.subnet-id
  key_name                    = aws_key_pair.ssh-public-key.key_name
}
