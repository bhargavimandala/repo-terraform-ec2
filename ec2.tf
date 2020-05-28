 resource "aws_instance" "ec2" {
  ami           = "${var.ami}"
  instance_type = "${var.instance}"
  key_name      = "${var.keyname}"
  subnet_id="${var.subnet_2b}"
  availability_zone="${var.ec2_zone}"
  vpc_security_group_ids = ["${aws_security_group.ec2_sg.id}"]
  iam_instance_profile = "${aws_iam_instance_profile.ec2_profile.id}"
  

  tags = {
    Name = "${var.global_product}.${var.global_environment}-ec2"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = "${aws_ebs_volume.ec2_ebs.id}"
  instance_id = "${aws_instance.ec2.id}"
}
