resource "aws_instance" "test1" {
  # Loops 3 times because the map has 3 key-value pairs
  count = length(var.ami_ids_ex1)

  # Converts map keys to a list: ["linux", "ubuntu", "redhat"]
  # Then grabs the AMI matching the current index number
  ami           = var.ami_ids_ex1[keys(var.ami_ids_ex1)[count.index]]
  instance_type = var.instance_type_ex1[count.index]
  
  tags = {
    Name = var.ec2_name_tag_ex1[count.index]
  }
}
