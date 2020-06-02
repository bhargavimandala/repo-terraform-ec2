resource "aws_elb" "elb" {
  name               = "elb-ec2"
  availability_zones = aws_instance.ec2[*].availability_zone
  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }
  instances                   = aws_instance.ec2.*.id
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "${var.global_product}.${var.global_environment}-elb"

  }
}

