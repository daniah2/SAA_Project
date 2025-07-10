output "vpc-id" {
  value = aws_vpc.main-vpc.id
}

output "public-subnets-ids" {
  value = { for subnet-name, subnet in aws_subnet.public-subnets : subnet-name => subnet.id }
}

output "private-subnets-ids" {
  value = { for subnet-name, subnet in aws_subnet.private-subnets : subnet-name => subnet.id }
}

output "security-groups-ids" {
  value = {
    "${aws_security_group.frontend-load-balancer-sg.name}" = "${aws_security_group.frontend-load-balancer-sg.id}"
    "${aws_security_group.backend-load-balancer-sg.name}"  = "${aws_security_group.backend-load-balancer-sg.id}"
    "${aws_security_group.frontend-instances-sg.name}"     = "${aws_security_group.frontend-instances-sg.id}"
    "${aws_security_group.backend-instances-sg.name}"      = "${aws_security_group.backend-instances-sg.id}"
    "${aws_security_group.rds-instances-sg.name}"          = "${aws_security_group.rds-instances-sg.id}"
    "${aws_security_group.bastion-server-sg.name}"         = "${aws_security_group.bastion-server-sg.id}"
  }
}
