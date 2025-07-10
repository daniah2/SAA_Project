resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.main-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-vpc-igw.id
  }
}

resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.main-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public-nat-gw.id
  }
}

resource "aws_route_table_association" "public-routes" {
  route_table_id = aws_route_table.public-route-table.id
  for_each       = aws_subnet.public-subnets
  subnet_id      = each.value.id
}

resource "aws_route_table_association" "private-routes" {
  route_table_id = aws_route_table.private-route-table.id
  for_each       = aws_subnet.private-subnets
  subnet_id      = each.value.id
}
