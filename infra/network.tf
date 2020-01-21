# VPC
resource "aws_vpc" "techlog_vpc" {
  cidr_block = "${var.root_segment}"
  tags = {
    Name = "${var.app_name}"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "techlog_vpc-igw" {
  vpc_id = "${aws_vpc.techlog_vpc.id}"
  tags = {
    Name = "${var.app_name} igw"
  }
}

# Public Subne
resource "aws_subnet" "techlog_vpc-public-subnet1" {
  vpc_id = "${aws_vpc.techlog_vpc.id}"
  cidr_block = "${var.public_segment1}"
  availability_zone = "${var.public_segment1_az}"
  tags = {
    Name = "${var.app_name} public-subnet1"
  }
}

resource "aws_subnet" "techlog_vpc-public-subnet2" {
  vpc_id = "${aws_vpc.techlog_vpc.id}"
  cidr_block = "${var.public_segment2}"
  availability_zone = "${var.public_segment2_az}"
  tags = {
    Name = "${var.app_name} public-subnet2"
  }
}

# Private Subnet
resource "aws_subnet" "techlog_vpc-private-subnet1" {
  vpc_id = "${aws_vpc.techlog_vpc.id}"
  cidr_block = "${var.private_segment1}"
  availability_zone = "${var.private_segment1_az}"
  tags = {
    Name = "${var.app_name} private-subnet1"
  }
}

resource "aws_subnet" "techlog_vpc-private-subnet2" {
  vpc_id = "${aws_vpc.techlog_vpc.id}"
  cidr_block = "${var.private_segment2}"
  availability_zone = "${var.private_segment2_az}"
  tags = {
    Name = "${var.app_name} private-subnet2"
  }
}

# Routes Table
resource "aws_route_table" "techlog_vpc-public-rt" {
  vpc_id = "${aws_vpc.techlog_vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.techlog_vpc-igw.id}"
  }
  tags = {
    Name = "${var.app_name} public-rt"
  }
}

resource "aws_route_table_association" "techlog_vpc-rta1" {
  subnet_id = "${aws_subnet.techlog_vpc-public-subnet1.id}"
  route_table_id = "${aws_route_table.techlog_vpc-public-rt.id}"
}

resource "aws_route_table_association" "techlog_vpc-rta2" {
  subnet_id = "${aws_subnet.techlog_vpc-public-subnet2.id}"
  route_table_id = "${aws_route_table.techlog_vpc-public-rt.id}"
}
