# VPC
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "vpc_tag" {
  default = "Test"
}

# Public Subnet

variable "publicsubnet_cidr" {
  default = "10.0.1.0/24"
}

variable "publicsubnet_tag" {
  default = "Environment.Test.Publicsubnet"
}


# Private Subnet

variable "privatesubnet_cidr" {
  default = "10.0.2.0/24"
}

variable "privatesubnet_tag" {
  default = "Environment.Test.Privatesubnet"
}
