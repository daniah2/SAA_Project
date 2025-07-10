resource "aws_eip" "nat-gw-ip" {
  tags = { Name = "nat-gw-ip" }
}

resource "aws_nat_gateway" "public-nat-gw" {
  allocation_id = aws_eip.nat-gw-ip.id
  subnet_id     = aws_subnet.public-subnets["${var.nat-gw-subnet-name}"].id
  tags          = { Name = "public-nat-gw" }
}
