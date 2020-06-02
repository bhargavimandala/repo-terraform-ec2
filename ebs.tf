resource "aws_ebs_volume" "ec2_ebs" {
  count             = "${var.ec2_instance_count * var.ec2_ebs_volume_count}"
  availability_zone = "${element(aws_instance.ec2.*.availability_zone, count.index)}"
  size              = 5

  tags = {
    Name = "${var.global_product}.${var.global_environment}-ec2_ebs"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  count       = "${var.ec2_instance_count * var.ec2_ebs_volume_count}"
  device_name = "${element(var.device_names, count.index)}"
  volume_id   = "${aws_ebs_volume.ec2_ebs.*.id[count.index]}"
  instance_id = "${element(aws_instance.ec2.*.id, count.index)}"
}

