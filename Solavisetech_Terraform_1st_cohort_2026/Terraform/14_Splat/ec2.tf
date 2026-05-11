# Below is the resource block which creates EC2 Instance
resource "aws_instance" "test" {
  count         = 10
  ami           = "ami-06a73f9d93a3879b5"
  instance_type = "t3.micro"
  tags = {
    Name = "tester"
  }
}

output "public_ip" {
    value = aws_instance.test[*].public_ip
}





