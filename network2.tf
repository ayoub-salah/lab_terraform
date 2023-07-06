//NAT & private subnets routing
resource "aws_eip" "ayoub_eip_nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.ayoub_eip_nat.id
  subnet_id     = aws_subnet.ayoub_subnet["public_subnet_1"].id
}

resource "aws_route_table" "ayoub_route_table_private_1" {
  vpc_id = aws_vpc.ayoub_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
}

resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.ayoub_subnet["private_subnet_1"].id
  route_table_id = aws_route_table.ayoub_route_table_private_1.id
}

resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.ayoub_subnet["private_subnet_2"].id
  route_table_id = aws_route_table.ayoub_route_table_private_1.id
}