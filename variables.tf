variable "keyname" {}
variable "region" {}
variable "ami" {}
variable "instance" {}
variable "global_product" {}
variable "global_environment" {}
variable "device_names" {
  type = list
}
variable "ec2_ebs_volume_count" {

  default = 1
}

variable "ec2_instance_count" {
  default = 2

}
variable "availability_zones" {
  description = "Run the EC2 Instances in these Availability Zones"

}

variable "vpc_cidr" {
default = "10.0.0.0/16"

}

variable "public_cidr" {
type = "list"
default = ["10.0.1.0/24","10.0.2.0/24"] 

}


variable "private_cidr" {
type = "list"
default = ["10.0.3.0/24","10.0.4.0/24"]

}
