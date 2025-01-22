// create vpc to accomodate 2 public and 2 private subnets 
resource "aws_vpc" "alb-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  tags = {
    name = "alb-vpc"
  }
}

// create public subnets in 2 availability zones
resource "aws_subnet" "pub-A" {
  vpc_id                  = aws_vpc.alb-vpc.id
  availability_zone       = "us-east-1a"
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "pub-B" {
  vpc_id                  = aws_vpc.alb-vpc.id
  availability_zone       = "us-east-1b"
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = true

}

// create private subnets for 2 availability zones
resource "aws_subnet" "private-A" {
  vpc_id            = aws_vpc.alb-vpc.id
  availability_zone = "us-east-1a"
  cidr_block        = "10.0.1.0/24"

}

resource "aws_subnet" "private-B" {
  vpc_id            = aws_vpc.alb-vpc.id
  availability_zone = "us-east-1b"
  cidr_block        = "10.0.2.0/24"

}


// create internate gateway for public internet access
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.alb-vpc.id

  tags = {
    name = "alb-IGW"
  }
}

// elastic IP for nat gateway
resource "aws_eip" "nat_eip" {}

//Create NAT gateway in public subnet
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.pub-A.id
  tags = {
    name = "vpc-nat-gateway"

  }

}

// create route table for public internet access
resource "aws_route_table" "pub-rt" {
  vpc_id = aws_vpc.alb-vpc.id

  //Route for public subnets to the internet gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
}

// Create route-table association for public-A subnet
resource "aws_route_table_association" "pub-A" {
  subnet_id      = aws_subnet.pub-A.id
  route_table_id = aws_route_table.pub-rt.id
}

// Create route-tabe association for Public-B subnet
resource "aws_route_table_association" "pub-B" {
  subnet_id      = aws_subnet.pub-B.id
  route_table_id = aws_route_table.pub-rt.id

}

// create route table for private subnet
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.alb-vpc.id

  // Route for private subnets to Nat gateway
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
}

// Create route-table association for private subnets
resource "aws_route_table_association" "private-A" {
  subnet_id      = aws_subnet.private-A.id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_route_table_association" "private-B" {
  subnet_id      = aws_subnet.private-B.id
  route_table_id = aws_route_table.private-rt.id
}