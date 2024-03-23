resource "aws_security_group" "fp01_alb_sg" {
  name        = "devopsik_elb_sg"
  description = "HTTPS traffic"
  vpc_id      = aws_vpc.fp01_vpc.id

  ingress {
    from_port   = 777
    to_port     = 777
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
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
    Name = "fp01_alb_sg"
  }
}