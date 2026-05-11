
# Below is the provider which helps in connecting with AWS Account
provider "aws" {
  region = "sa-east-1"
  profile = "default"
}


# Below is the resource block which creates EC2 Instance
resource "aws_instance" "test" {
  ami           = "ami-06a73f9d93a3879b5"
  instance_type = "t3.micro"
  tags = {
    Name = "Dev"
  }

  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> private_ips.txt"
  }
}









