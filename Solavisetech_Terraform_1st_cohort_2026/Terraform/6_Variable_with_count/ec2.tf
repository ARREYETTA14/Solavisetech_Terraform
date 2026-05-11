# Below is the resource block which creates EC2 Instance
resource "aws_instance" "test" {
  count = length(var.ec2_name_tag)

  ami           = var.ami_ids[count.index]
  instance_type = var.instance_type[count.index]
  tags = {
    Name = var.ec2_name_tag[count.index]
  }
}


# # Below is the resource block which creates EC2 Instance
# resource "aws_instance" "test" {

#   ami           = var.ami_ids["ubuntu"]
#   instance_type = var.instance_type[3]
#   tags = {
#     Name = var.ec2_name_tag[0]
#   }
  
# }