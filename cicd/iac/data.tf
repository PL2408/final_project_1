data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

data "aws_route53_zone" "visitka_hz" {
  name         = "devopsik.iturbo.click"
  private_zone = false
}

data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}