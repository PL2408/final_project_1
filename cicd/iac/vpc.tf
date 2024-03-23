resource "aws_vpc" "fp01_vpc" {
  cidr_block           = "10.70.55.128/26"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "final_prj_01_vpc"
  }
}
