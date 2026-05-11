# Below is the resource block which creates EC2 Instance
# resource "aws_instance" "test" {
#   ami           = ""
#   instance_type = ""
#   tags = {
#     Name = ""
#   }
# }
resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket"

  tags = {
    Name        = "bucket_efsaf"
    Environment = "Dev"
  }
}

# Below is the provider which helps in connecting with AWS Account
provider "aws" {
  region = "sa-east-1"
  access_key = ""
  secret_key = ""
}