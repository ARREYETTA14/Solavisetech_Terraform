## Create VPC

module "my_vpc_module" {
  source = "./modules/vpc_module"
}


resource "aws_instance" "ec2" {
  ami = "ami-0ba39aef11896824a" //sa-east-1
  instance_type = "t3.micro"
  subnet_id = module.my_vpc_module.public_subnet_id
  tags = {
    Environment = "Test_Ec2"
  }
}

# Below is the provider which helps in connecting with AWS Account
    provider "aws" {
    region = "sa-east-1"
    profile = "default"
}
