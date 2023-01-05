resource "aws_security_group" "jenkins_server" {
  name        = "jenkins_server"
  description = "Jenkins server access"
  vpc_id      = aws_vpc.fp01_vpc.id

  ingress {
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
}

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "final_prj_01_jenkins_sg"
  }
}