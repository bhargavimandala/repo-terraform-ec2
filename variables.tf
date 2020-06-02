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
  default = 3

}
variable "availability_zones" {
  description = "Run the EC2 Instances in these Availability Zones"

}
