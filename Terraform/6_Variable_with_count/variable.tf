# Below is the variables blocks
variable "ec2_name_tag_ex1" {
  default = ["name1", "name2", "name3"]
}

variable "instance_type_ex1" {
  default = ["t2.micro", "t2.nano", "t2.small"]
}

variable "ami_ids_ex1" {
  default = {
    linux  = "ami-06a73f9d93a3879b5"
    ubuntu = "ami-06a73f9d93a3879b5"
    redhat = "ami-06a73f9d93a3879b5"
  }
}
