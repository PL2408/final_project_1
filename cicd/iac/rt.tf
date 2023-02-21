resource "aws_route_table" "fp01_rt" {
  vpc_id = aws_vpc.fp01_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.fp01_igw.id
  }

  tags = {
    Name = "fp01_rt"
  }
}