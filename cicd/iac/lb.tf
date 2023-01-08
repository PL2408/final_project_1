resource "aws_lb" "fp01_alb" {
  name               = "fp01-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.fp01_alb_sg.id]
  subnets            = [aws_subnet.fp01_pub_sb01.id, aws_subnet.fp01_pub_sb02.id]

    tags = {
    Name = "final_prj_01_vpc"
  }
}

resource "aws_lb_listener" "fp01_alb" {
  load_balancer_arn = aws_lb.fp01_alb.arn
  port              = "777"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.fp01_tg.arn
  }
}