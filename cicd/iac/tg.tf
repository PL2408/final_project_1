resource "aws_lb_target_group" "fp01_tg" {
  name     = "fp01-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.fp01_vpc.id
  health_check {
    path     = "/login"
    port     = "traffic-port"
    interval = 30
    timeout  = 10
  }
}

resource "aws_alb_target_group_attachment" "jenkins_tga" {
  target_group_arn = aws_lb_target_group.fp01_tg.arn
  target_id        = aws_instance.jenkins_server.id
}



resource "aws_lb_target_group" "fp01_web_tg" {
  name     = "fp01-web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.fp01_vpc.id
  health_check {
      path     = "/login"
      port     = "traffic-port"
      interval = 30
      timeout  = 10
  }
}
resource "aws_alb_target_group_attachment" "web_tga" {
  target_group_arn = aws_lb_target_group.fp01_web_tg.arn
  target_id        = aws_instance.web_server.id
}