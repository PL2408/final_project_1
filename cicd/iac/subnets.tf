resource "aws_subnet" "fp01_pub_sb01" {
  vpc_id            = aws_vpc.fp01_vpc.id
  cidr_block        = "10.70.55.128/27"
  availability_zone = "eu-central-1a"
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.fp01_pub_sb01.id
  route_table_id = aws_route_table.fp01_rt.id
}

resource "aws_subnet" "fp01_pub_sb02" {
  vpc_id            = aws_vpc.fp01_vpc.id
  cidr_block        = "10.70.55.160/27"
  availability_zone = "eu-central-1b"
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.fp01_pub_sb02.id
  route_table_id = aws_route_table.fp01_rt.id
}

