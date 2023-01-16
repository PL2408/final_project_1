#--------------------jenkins_server------------------
resource "aws_instance" "jenkins_server" {
  ami                         = data.aws_ami.amazon-linux-2.id
  instance_type               = "t3.micro"
  key_name                    = "p_l"
  subnet_id                   = aws_subnet.fp01_pub_sb01.id
  vpc_security_group_ids      = [aws_security_group.jenkins_server.id]
  user_data                   = file("config/user_data_jns.sh")
  associate_public_ip_address = true
  user_data_replace_on_change = true
  private_ip                  = "10.70.55.155"
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name

  root_block_device {
    volume_type           = "gp3"
    volume_size           = 20
    delete_on_termination = true
  }

  tags = {
    Name = "jenkins_server"
  }
}


output "jenkins_public_ip" {
  value = aws_instance.jenkins_server.public_ip
}


#--------------------jenkins_agent------------------
resource "aws_instance" "jenkins_agent" {
  ami                         = data.aws_ami.amazon-linux-2.id
  instance_type               = "t3.micro"
  key_name                    = "p_l"
  subnet_id                   = aws_subnet.fp01_pub_sb01.id
  vpc_security_group_ids      = [aws_security_group.jenkins_agent.id]
  user_data                   = file("config/user_data_agt.sh")
  associate_public_ip_address = true
  user_data_replace_on_change = true
  private_ip                  = "10.70.55.156"
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name

  root_block_device {
    volume_type           = "gp3"
    volume_size           = 20
    delete_on_termination = true
  }

  tags = {
    Name = "jenkins_agent"
  }
}

output "jenkins_public_ip_01" {
  value = aws_instance.jenkins_agent.public_ip
}
