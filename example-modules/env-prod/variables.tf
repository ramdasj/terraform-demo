# Required variables
variable "env" {}

variable "count" {}
variable "vpc_id" {}
variable "subnet_id" {}

# Variables with defaults
variable "instance_type" {
  default = "t2.micro"
}

variable "region" {
  default = "ap-southeast-2"
}

variable "availablity_zones" {
  default = "ap-southeast-2a,ap-southeast-2b,ap-southeast-2c"
}

variable "product" {
  default = "demoapp"
}
