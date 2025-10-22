# Create VPC

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Environment = var.vpc_tag
  }
}

# Create Public Subnet

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.publicsubnet_cidr

  tags = {
    Name = var.publicsubnet_tag
  }
}


# Create Private Subnet

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.privatesubnet_cidr

  tags = {
    Name = var.privatesubnet_tag
  }
}
