terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# aws provider
provider "aws" {
  region = "us-east-2"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}

# path to ssh public key
variable "public_key_path" {
  default = "~/.ssh/3-tier.pub"
}

# name of the key to be used
variable "key_name" {
  default = "kpmg-ssh-key"
}

# EC2 machine instance type 
variable "instance_type" {
  default = "t2.micro"
}
