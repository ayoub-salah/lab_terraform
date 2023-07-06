resource "aws_vpc" "ayoub_vpc" {
  cidr_block = "192.168.1.0/24"
  tags = {
    Name = "ayoub_vpc"
  }
}

resource "aws_subnet" "ayoub_subnet" {
for_each = {
    public_subnet_1  = { cidr_block = "192.168.1.0/26", availability_zone = "us-east-1a", map_public_ip = true },
    public_subnet_2  = { cidr_block = "192.168.1.64/26", availability_zone = "us-east-1b", map_public_ip = true },
    private_subnet_1 = { cidr_block = "192.168.1.128/26", availability_zone = "us-east-1a", map_public_ip = false },
    private_subnet_2 = { cidr_block = "192.168.1.192/26", availability_zone = "us-east-1b", map_public_ip = false },
  }

  vpc_id                  = aws_vpc.ayoub_vpc.id
  cidr_block              = each.value.cidr_block
  map_public_ip_on_launch = each.value.map_public_ip
  availability_zone       = each.value.availability_zone

  tags = {
    Name = each.key
  }
}

resource "aws_internet_gateway" "ayoub_gateway" {
  vpc_id = aws_vpc.ayoub_vpc.id
  tags = {
    Name = "ayoub_gateway"
  }
}

resource "aws_route_table" "ayoub_route_table_1" {
  vpc_id = aws_vpc.ayoub_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ayoub_gateway.id
  }

  tags = {
    Name = "ayoub_route_table_1"
  }
}

resource "aws_route_table_association" "subnet_public_1_route_table" {
  subnet_id      = aws_subnet.ayoub_subnet["public_subnet_1"].id
  route_table_id = aws_route_table.ayoub_route_table_1.id
}

