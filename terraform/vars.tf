variable "ec2_ami" {
  type = map

  default = {
    eu-central-1 = "ami-076bdd070268f9b8d"
  }
}

variable "region" {
  default = "eu-central-1"
}

variable "instance_type" {
  type = string
}