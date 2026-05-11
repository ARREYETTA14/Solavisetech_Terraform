#prod_env = true  -->   test environment  DOCUMENTATION
#
#prod_env = false -->   prod environment

###########################################################################################
# Example - 1
###########################################################################################

# # Below is the variables blocks
# variable "prod_env" {
#     type = bool
#  default = false
# }

# # Below is the resource block which creates EC2 Instance
# resource "aws_instance" "test" {
#  count         = false == true ? 3 : 0
#  ami           = "ami-098e42ae54c764c35"
#  instance_type = "t2.micro"
# }

# resource "aws_instance" "prod" {
#  count         = false == false ? 1 : 0
#  ami           = "ami-098e42ae54c764c35"
#  instance_type = "t2.large"
# }


###########################################################################################
# Example - 2 - prompts you to pass value at runtime
###########################################################################################

# Below is the variables blocks
# variable "prod_env" {
#     type = bool
# }

# # Below is the resource block which creates EC2 Instance
# resource "aws_instance" "test" {
#  count         = var.prod_env == true ? 3 : 0
#  ami           = "ami-098e42ae54c764c35"
#  instance_type = "t2.micro"
# }

# resource "aws_instance" "prod" {
#  count         = var.prod_env == false ? 1 : 0
#  ami           = "ami-098e42ae54c764c35"
#  instance_type = "t2.large"
# }


###########################################################################################
# Example - 3
###########################################################################################

## Below is the variables blocks
#variable "prod_env" {
#   default = "dobie"
#}
#
## Below is the resource block which creates EC2 Instance
#resource "aws_instance" "second_example" {
#  ami           = var.prod_env == "dobie" ? "ami-XXXXXXXXXXX" : "ami-XXXXXXXXXXX"
#  instance_type = "t2.micro"
#}




