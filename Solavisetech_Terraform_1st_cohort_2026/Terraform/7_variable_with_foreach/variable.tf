# Below is the variables blocks
variable "ec2_name_tag" {
  default = ["name1", "name2","name3"]
}

variable "instance_type" {
            #   0          1          2
  default = ["t2.micro", "t2.nano","t2.small"]
}

variable "ami_ids" {
  default = {
    0 = "ami-06a73f9d93a3879b5",
    1 = "ami-06a73f9d93a3879b5",
    2 = "ami-06a73f9d93a3879b5"
  }
}