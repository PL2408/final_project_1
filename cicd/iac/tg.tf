resource "aws_lb_target_group" "fp01_tg" {
  name     = "fp01-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_vpc" "main" {
  cidr_block = "10.70.55.128/26"
}