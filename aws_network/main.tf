variable "vpc_cidr" {
  description = "CIDR for VPC"
  type        = string
}

variable "subnets" {
  description = "Map of subnets to create"
  type        = map(object({ cidr_block = string, availability_zone = string, map_public_ip = bool }))
}

variable "tags" {
  description = "Map of tags to assign to the resources"
  type        = map(string)
  default     = {}
}

resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  tags = merge(
    var.tags,
    {
      Name = "vpc"
    }
  )
}

resource "aws_subnet" "this" {
  for_each = var.subnets

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value.cidr_block
  map_public_ip_on_launch = each.value.map_public_ip
  availability_zone       = each.value.availability_zone

  tags = merge(
    var.tags,
    {
      Name = each.key
    }
  )
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    var.tags,
    {
      Name = "internet_gateway"
    }
  )
}

resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(
    var.tags,
    {
      Name = "route_table"
    }
  )
}

resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.this["public_subnet_1"].id
  route_table_id = aws_route_table.this.id
}
