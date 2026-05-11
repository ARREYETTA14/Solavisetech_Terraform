# Functions on terraform documentation and DEMO

# # Below is the provider which helps in connecting with AWS Account
# provider "aws" {
#   region     = ""
# }

# # Local Variables Block
# locals {
#   time = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
# }


# # Below is the resource block which creates EC2 Instance
# resource "aws_instance" "myec2" {
#   ami = "ami-XXXXXXXXXXXX"
#   instance_type = "t2.micro"
#   tags = {
#     date_created = local.time
#   }
# }