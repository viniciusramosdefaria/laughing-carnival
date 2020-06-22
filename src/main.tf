variable "region" {
  default = ""
}
provider "aws" {
  region  = var.region
  version = "2.57.0"
}

terraform {
  required_version = "0.12.13"
  required_providers {
    aws        = "2.57.0"
  }

  backend "s3" {
  }
}
	
variable "vpc_name" {
  type = string
}
variable "vpc_cidr" {
  type = string
}

variable "vpc_azs" {
  type = list(string)
}

variable "customer_name" {
  default = ""
}
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  version = "~> v2.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.vpc_azs
  private_subnets = [
  for num in [1,2,3]:
    cidrsubnet(var.vpc_cidr, 5, num)
  ]
  public_subnets  = [
  for num in [4,5,6]:
  cidrsubnet(var.vpc_cidr, 5, num)
  ]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = var.customer_name
  }
}

