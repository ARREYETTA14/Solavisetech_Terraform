
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

  key_name      = "webserver"
  
  vpc_security_group_ids = ["sg-0624718f5cedf68a5"]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("C:/Users/arrey/Downloads/webserver.pem") 
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo dnf update -y",
      "sudo dnf install httpd -y",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "sudo bash -c 'echo \"<h1> Welcome to DevOps Learning </h1>\" > /var/www/html/index.html'"
    ]
  }
}

output "public_ip" {
    value = aws_instance.test.public_ip 
}



