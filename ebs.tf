 resource "aws_ebs_volume" "ec2_ebs" {
  availability_zone = "${var.ec2_zone}"
  size              = 5

  tags = {
    Name = "${var.global_product}.${var.global_environment}-ec2_ebs"
  }
}
