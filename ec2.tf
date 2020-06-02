#ec2 server 
  resource "aws_instance" "ec2" {
  count = "${var.ec2_instance_count}"
  ami           = "${var.ami}"
  instance_type = "${var.instance}"
  key_name      = "${var.keyname}"
  vpc_security_group_ids = ["${aws_security_group.ec2_sg.id}"]
  subnet_id = "${aws_subnet.subnet_public.id}"  
  iam_instance_profile = "${aws_iam_instance_profile.ec2_profile.id}"
   availability_zone = "${element(var.availability_zones, count.index)}"  
tags = {
    Name = "${var.global_product}.${var.global_environment}-ec2-${count.index+1}"
  }
}


  resource "aws_vpc" "vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "${var.global_product}.${var.global_environment}-vpc"
  }
}


resource "aws_subnet" "subnet_public" {
  vpc_id     = "${aws_vpc.vpc.id}"
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "${var.global_product}.${var.global_environment}-subnet_public"
  }
}

