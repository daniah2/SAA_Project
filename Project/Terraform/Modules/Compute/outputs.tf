output "frontend-lb-dns" {
  value = aws_lb.frontend-lb.dns_name
}

output "bastion-server-public-ip" {
  value = aws_instance.bastion-server.public_ip
}

output "asg-names" {
  value = {
    frontend = aws_autoscaling_group.frontend-autoscaling-group.name
    backend  = aws_autoscaling_group.backend-autoscaling-group.name
  }
}
