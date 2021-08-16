resource "aws_vpc" "dmz" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = { Name = "DMZ-VPC" }
}

resource "aws_subnet" "dmz-public-2a" {
  vpc_id            = aws_vpc.dmz.id
  cidr_block        = "10.0.16.0/24"
  availability_zone = "ap-northeast-2a"
  map_public_ip_on_launch = true

  tags = { Name = "DMZ Public Subnet 2A" }
}

resource "aws_subnet" "dmz-public-2c" {
  vpc_id            = aws_vpc.dmz.id
  cidr_block        = "10.0.32.0/24"
  availability_zone = "ap-northeast-2c"
  map_public_ip_on_launch = true

  tags = { Name = "DMZ Public Subnet 2C" }
}

resource "aws_subnet" "dmz-private-2a" {
  vpc_id 			= aws_vpc.dmz.id
  cidr_block 		= "10.0.48.0/24"
  availability_zone = "ap-northeast-2a"
  
  tags = { Name = "DMZ Private Subnet 2A"}
}

resource "aws_subnet" "dmz-private-2c" {
  vpc_id 			= aws_vpc.dmz.id
  cidr_block		= "10.0.54.0/24"
  availability_zone = "ap-northeast-2c"
  
  tags = { Name = "DMZ Private Subnet 2C" }
}

resource "aws_route" "dmz-public-route" {
  route_table_id = aws_vpc.dmz.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.dmz.id
}

resource "aws_internet_gateway" "dmz" {
  vpc_id = "${aws_vpc.dmz.id}"

  tags = { Name = "DMZ Internet Gateway" }
}
