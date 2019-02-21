# Provider declaration
provider "aws" {
  # AWS credentials should be declared as environment variables.
  region = "${var.region}"
}

# Retrieves latest Amazon Linux AMI.
data "aws_ami" "aws_linux_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "web_ec2" {
  source    = "../modules/ec2"
  env       = "${var.env}"
  ami_id    = "${data.aws_ami.aws_linux_ami.id}"
  count     = "${var.count}"
  subnet_id = "${var.subnet_id}"
}

