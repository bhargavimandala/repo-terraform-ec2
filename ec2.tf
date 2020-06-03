#ec2 server 
  resource "aws_instance" "ec2" {
  count = "${var.ec2_instance_count}"
  ami           = "${var.ami}"
  instance_type = "${var.instance}"
  key_name      = "${var.keyname}"
  vpc_security_group_ids = ["${aws_security_group.ec2_sg.id}"]
  iam_instance_profile = "${aws_iam_instance_profile.ec2_profile.id}"
   availability_zone = "${element(var.availability_zones, count.index)}" 
   subnet_id = "${element(aws_subnet.public_subnet.*.id, count.index)}"
tags = {
    Name = "${var.global_product}.${var.global_environment}-ec2-${count.index+1}"
  }
}



 



