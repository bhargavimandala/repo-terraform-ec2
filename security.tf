  # Security Group Creation
resource "aws_security_group" "ec2_sg" {
  name   = "${var.global_product}.${var.global_environment}-ec2_sg"
  vpc_id = "${aws_vpc.vpc.id}"

   ingress {
    description = "ec2 sg"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.global_product}.${var.global_environment}-ec2_sg"
  }
}
