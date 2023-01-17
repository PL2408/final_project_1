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
  ssl_policy        = "ELBSecurityPolicy-FS-1-2-2019-08"
  certificate_arn   = aws_acm_certificate.cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.fp01_tg.arn
  }
}

resource "aws_lb_listener" "fp01_web_alb" {
  load_balancer_arn = aws_lb.fp01_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-FS-1-2-2019-08"
  certificate_arn   = aws_acm_certificate.cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.fp01_web_tg.arn
  }
}