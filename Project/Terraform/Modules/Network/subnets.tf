resource "aws_subnet" "public-subnets" {
  for_each          = { for public-subnet in var.public-subnets : public-subnet.name => public-subnet }
  vpc_id            = aws_vpc.main-vpc.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.zone
  tags              = { Name = each.key }
}

resource "aws_subnet" "private-subnets" {
  for_each          = { for private-subnet in var.private-subnets : private-subnet.name => private-subnet }
  vpc_id            = aws_vpc.main-vpc.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.zone
  tags              = { Name = each.key }
}

