resource "aws_internet_gateway" "fp01_igw" {
  vpc_id = aws_vpc.fp01_vpc.id

  tags = {
    Name = "final_prj_01_igw"
  }
}