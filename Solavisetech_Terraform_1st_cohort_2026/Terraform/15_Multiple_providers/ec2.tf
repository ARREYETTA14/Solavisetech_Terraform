# # Below is the resource block which creates EC2 Instance
# resource "aws_instance" "test" {
#   ami           = ""
#   instance_type = ""
#   tags = {
#     Name = ""
#   }
# }

# # Below is the resource block which creates EC2 Instance
# resource "aws_instance" "test" {
#   provider = aws.test
#   ami           = ""
#   instance_type = ""
#   tags = {
#     Name = ""
#   }
# }





## Providers configured for different regions
provider "aws" {
  region = "sa-east-1"
}

provider "aws" {
  alias  = "Dev"
  region = "us-east-1"
}

locals {
  common_tags = {
    Name        = "Development"
    Environment = "Dev"
    Owner       = "DevOps Team"
    Createdby   = "Augustine"
    Time        = formatdate("EEEE_DD-MMM-YY_hh-mm-ss_ZZZ", timestamp())
  }
}

## 1. AMI Search for sa-east-1 (Uses default provider)
data "aws_ami" "app_ami_sa" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-kernel-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

## 2. AMI Search for us-east-1 (Explicitly uses aws.Dev provider)
data "aws_ami" "app_ami_us" {
  provider    = aws.Dev
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-kernel-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

## Instance deploying to sa-east-1
resource "aws_instance" "my_ec2_instance3" {
  ami           = data.aws_ami.app_ami_sa.id
  instance_type = "t2.micro"
  tags          = merge(local.common_tags, { email = "abjjbnnfjsdjf@gmail.com" })
}

## Instance deploying to us-east-1
resource "aws_instance" "my_ec2_instance4" {
  provider      = aws.Dev
  ami           = data.aws_ami.app_ami_us.id
  instance_type = "t3.micro"
  tags          = merge(local.common_tags, { email = "abjjbnnfjsdjf@gmail.com" })
}

## Corrected output syntax (removed the invalid [1] index)
output "public_ip" {
  value = aws_instance.my_ec2_instance3.public_ip
}
