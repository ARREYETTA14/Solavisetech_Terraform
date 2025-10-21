# # Below is the provider which helps in connecting with AWS Account
# provider "aws" {
#   region     = "sa-east-1"
#   profile = "default"
# }

# # # Below is the Data Sources Block
# data "aws_ami" "app_ami" {
#   most_recent = true
#   owners = ["amazon"]

#   filter {
#     name   = "name"
#     values = ["al2023-ami-2023.*-kernel-6.1-x86_64"]
#   }
  
#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
  
# }

# output "test" {
#  value = data.aws_ami.app_ami.id
# }

# # advantageous
# resource "aws_instance" "instance-1" {
#     ami = data.aws_ami.app_ami.id
#    instance_type = "t2.micro"
# }













