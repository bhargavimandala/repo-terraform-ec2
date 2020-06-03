keyname            = "awskeys-2"
region             = "eu-west-2"
ami                = "ami-0330ffc12d7224386"
instance           = "t2.micro"
global_product     = "mb"
global_environment = "dev"
#ec2_zone="eu-west-2b"
device_names = [
  "/dev/sdh",
  "/dev/sdi",
  "/dev/sdg"
]
availability_zones = ["eu-west-2a", "eu-west-2b"]
