# Provider declaration
provider "aws" {
  # AWS credentials should be declared as environment variables.
  #if possible check for multiple profile if there is conflict in multiple accounts
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

resource "aws_instance" "an_ec2_instance" {
  count         = "${var.count}"
  ami           = "${data.aws_ami.aws_linux_ami.id}"
  instance_type = "${var.instance_type}"

  subnet_id = "${var.count == 1 ? var.subnet_id : element(split(",", var.subnet_id), count.index)}"

  tags = {
    Name        = "${Prod or QA }"
    Product     = "${var.product}"
    Environment = "${var.env}"
    Terraform   = "true"
  }
}

