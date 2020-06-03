# creating vpc
  resource "aws_vpc" "vpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"
  tags = {
    Name = "${var.global_product}.${var.global_environment}-vpc"
  }
}


# Creating Internet Gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = {
    Name = "${var.global_product}.${var.global_environment}-gw"
  }
}



# Public Route Table

resource "aws_route_table" "public_route" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags = {
    Name = "${var.global_product}.${var.global_environment}-public_route"
  }
}





# Private Route Table

resource "aws_default_route_table" "private_route" {
  default_route_table_id = "${aws_vpc.vpc.default_route_table_id}"

  

  tags = {
    Name = "my-private-route-table"
  }
}



# create public subnet

resource "aws_subnet" "public_subnet" {
  count      = 2
  vpc_id     = "${aws_vpc.vpc.id}"  
  map_public_ip_on_launch = true
  cidr_block = "${var.public_cidr[count.index]}"  
  availability_zone = "${element(var.availability_zones, count.index)}"

  
  tags = {
    Name = "${var.global_product}.${var.global_environment}-public_subnet.${count.index + 1}"
  }
}


#craeting private subnet
  
resource "aws_subnet" "private_subnet" {
  count      = 2
  vpc_id     = "${aws_vpc.vpc.id}"
  map_public_ip_on_launch = true
  cidr_block = "${var.private_cidr[count.index]}"
  availability_zone = "${element(var.availability_zones, count.index)}"


  tags = {
    Name = "${var.global_product}.${var.global_environment}-private_subnet.${count.index + 1}"
  }
}



#Associate Public Subnet with Public Route Table
 
resource "aws_route_table_association" "public_subnet_assoc" {
  count          = 2
  route_table_id = "${aws_route_table.public_route.id}"
  subnet_id      = "${aws_subnet.public_subnet.*.id[count.index]}"
  depends_on     = ["aws_route_table.public_route", "aws_subnet.public_subnet"]
}


#Associate Public Subnet with Public Route Table
resource "aws_route_table_association" "private_subnet_assoc" {
  count          = 2
  route_table_id = "${aws_default_route_table.private_route.id}"
  subnet_id      = "${aws_subnet.private_subnet.*.id[count.index]}"
  depends_on     = ["aws_default_route_table.private_route", "aws_subnet.private_subnet"]
}


