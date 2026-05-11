# Below is the resource block which creates EC2 Instance
resource "aws_instance" "test" {
  ami           = "ami-06a73f9d93a3879b5"
  instance_type = "t3.micro"
  tags = {
    Name = "Tester"
  }
}

resource "aws_instance" "test1" {
  ami           = "ami-06a73f9d93a3879b5"
  instance_type = "t3.nano"
  tags = {
    Name = "Test"
  }
}