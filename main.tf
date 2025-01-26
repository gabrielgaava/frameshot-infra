provider "aws" {
    region = var.aws_region
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
    token = var.aws_session_token
}

terraform {
    backend "local" {
      path = "./terraform.tfstate"
    }
}

module "aurora" {
    source = "./modules/aurora"
    db_master_username = ""
    db_master_password = ""
}

module "vpc" {
    source = "./modules/vpc"
    env = "prod"
    azs = ["us-east-1a", "us-east-1b"]
    private_subnets = ["10.0.0.0/19", "10.0.32.0/19"]
    public_subnets = ["10.0.64.0/19", "10.0.96.0/19"]

    private_subnet_tags = {
      "kubernetes.io/role/internal-elb"               = 1
      "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    }
    
    public_subnet_tags = {
      "kubernetes.io/role/elb"                        = 1
      "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    }
}

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_session_token" {}
variable "aws_region" {}