 resource "aws_security_group" "ec2_sg" {
  name        = "${var.global_product}.${var.global_environment}-ec2_sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${var.vpc_id}"

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
