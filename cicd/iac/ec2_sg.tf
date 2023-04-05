# ------------------Jenkins_server_sg----------------------
resource "aws_security_group" "jenkins_server" {
  name        = "jenkins_server"
  description = "Jenkins server access"
  vpc_id      = aws_vpc.fp01_vpc.id

  ingress {
    description = "SSH traffic from my workstation"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  #["${chomp(data.http.myip.response_body)}/32"]
  }
  ingress {
    description     = "HTTP traffic from ALB"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.fp01_alb_sg.id]
  }
  egress {
    description      = "Outbound traffic"
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

# ------------------Agent_sg----------------------
resource "aws_security_group" "jenkins_agent" {
  name        = "jenkins_agent"
  description = "Access to jenkins agent"
  vpc_id      = aws_vpc.fp01_vpc.id

  ingress {
    description = "SSH traffic from my workstation"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  #["${chomp(data.http.myip.response_body)}/32"]
  }
  ingress {
    description     = "SSH traffic to jenkins_server_sg"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.jenkins_server.id]
  }
  egress {
    description      = "Outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "final_prj_01_agent_sg"
  }
}

resource "aws_security_group" "web_server_sg" {
  name        = "web_ec2_sg"
  description = "Access to web server"
  vpc_id      = aws_vpc.fp01_vpc.id

  ingress {
    description = "SSH traffic from my workstation"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  #["${chomp(data.http.myip.response_body)}/32"]
  }
  ingress {
    description     = "SSH traffic from jenkins_agent_sg"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.jenkins_agent.id]
  }
  ingress {
    description     = "HTTP traffic from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.fp01_alb_sg.id]
  }
  egress {
    description = "Outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "final_prj_01_web_server_sg"
  }
}