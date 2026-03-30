### provider block
provider "aws" {
  region  = "sa-east-1"
  profile = "default"  
}

####keypair
resource "tls_private_key" "generated" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "my_key" {
  key_name   = "my-key"
  public_key = tls_private_key.generated.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.generated.private_key_pem
  filename = "C:/Users/arrey/Downloads/my-key.pem"  
  file_permission = "0400"
}

### Network
#vpc
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

##subnets (public and private)

# public
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "sa-east-1a"
}

# private
resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "sa-east-1b"
}

### internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}


# Elastic IP for NAT
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

#NAT Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public.id
}

## Route tables
# public route table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# private route table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route" "private_nat" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

# Route Table Association
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private_rt.id
}

## SG
# public sg
resource "aws_security_group" "public_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# private sg
resource "aws_security_group" "private_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


### Data source
data "aws_ami" "app_ami" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-kernel-6.1-x86_64"]
  }
  
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  
}

### ec2 instances
# public instance

resource "aws_instance" "public_instance" {
  ami           = data.aws_ami.app_ami.id
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public.id


  key_name               = aws_key_pair.my_key.key_name
  vpc_security_group_ids = [aws_security_group.public_sg.id]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = tls_private_key.generated.private_key_pem
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo dnf update -y",
      "sudo dnf install -y httpd",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd"
    ]
  }

  provisioner "file" {
    source      = "index.html"
    destination = "/home/ec2-user/index.html"
  }

  provisioner "file" {
    source      = "styles.css"
    destination = "/home/ec2-user/styles.css"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /home/ec2-user/index.html /var/www/html/index.html",
      "sudo mv /home/ec2-user/styles.css /var/www/html/styles.css",
      "sudo systemctl restart httpd"
    ]
  }

  tags = {
    Name = "Public-Server"
  }
}

## private instance
resource "aws_instance" "private_instance" {
  ami           = data.aws_ami.app_ami.id
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.private.id


  key_name               = aws_key_pair.my_key.key_name
  vpc_security_group_ids = [aws_security_group.private_sg.id]

  tags = {
    Name = "Private-Server"
  }
}

## output 
output "publicip_public_instance" {
  value = aws_instance.public_instance.public_ip
}
