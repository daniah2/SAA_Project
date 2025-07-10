output "frontend-lb-dns" {
  value = module.compute.frontend-lb-dns
}

output "bastion-server-public-ip" {
  value = module.compute.bastion-server-public-ip
}
