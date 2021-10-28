terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-west-1"
}

locals {
  project_name= "Hola DavidT"
}

resource "aws_instance" "davidT" {
  ami = data.aws_ami.ubuntu.id
  instance_type=var.instance_type
  tags={
    "Name"="TAG-server-${local.project_name}"
  }
}