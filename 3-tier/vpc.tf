# creating a new vpc with dns resolution support
resource "aws_vpc" "vpc_kpmg" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = "${ aws_vpc.vpc_kpmg.id }"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-2a"
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = "${ aws_vpc.vpc_kpmg.id }"
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-2a"
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = "${ aws_vpc.vpc_kpmg.id }"
}

resource "aws_route" "external_route" {
  route_table_id         = "${ aws_vpc.vpc_kpmg.main_route_table_id }"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${ aws_internet_gateway.internet_gateway.id }"
}

resource "aws_eip" "elastic_ip" {
  vpc        = true
  depends_on = ["aws_internet_gateway.internet_gateway"]
}

resource "aws_nat_gateway" "nat" {
  allocation_id = "${ aws_eip.elastic_ip.id }"
  subnet_id     = "${ aws_subnet.public_subnet.id }"
  depends_on    = ["aws_internet_gateway.internet_gateway"]
}

resource "aws_route_table" "private_route_table" {
  vpc_id = "${ aws_vpc.vpc_kpmg.id }"
}

resource "aws_route" "private_route" {
  route_table_id         = "${ aws_route_table.private_route_table.id }"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${ aws_nat_gateway.nat.id }"
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = "${ aws_subnet.public_subnet.id }"
  route_table_id = "${ aws_vpc.vpc_kpmg.main_route_table_id }"
}

resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = "${ aws_subnet.private_subnet.id }"
  route_table_id = "${ aws_route_table.private_route_table.id }"
}