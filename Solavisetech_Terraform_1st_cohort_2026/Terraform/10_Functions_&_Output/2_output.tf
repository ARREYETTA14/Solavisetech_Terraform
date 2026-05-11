# Functions/Output on terraform documentation

# # Provider Block - Connects with AWS Account
# provider "aws" {
#   region = ""  # Replace with your desired AWS region
# }

# # Local Variables Block
# locals {
#   time = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
# }

# # Resource Block - Creates an AWS EC2 Instance
# resource "aws_instance" "myec2" {
#   ami           = "ami-XXXXXXXXXXXX"
#   instance_type = "t2.micro"
#   tags = {
#     date_created = local.time
#   }
# }

# #Output exposes Ip of instance

# # Output for the date_created tag of the EC2 instance
# output "ec2_date_created" {
#   value = aws_instance.myec2.tags["date_created"]
# }