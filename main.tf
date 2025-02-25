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
    required_version = ">= 1.0"
  
    required_providers {
      aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
      }
    }
}

locals {
  private_subnets_ip_bock = ["10.0.0.0/19", "10.0.32.0/19", "10.0.64.0/19"]
  public_subnets_ip_bock = ["10.0.96.0/19", "10.0.128.0/19", "10.0.160.0/19"]
}

module "cognito" {
  source = "./modules/cognito"
  aws_region = var.aws_region
  name = "frameshot-app"
}

module "sqs" {
  source = "./modules/sqs"
  sqs_queues = [ 
    {name = "S3Notifications", dead_letter_queue = false, is_fifo = false},
    {name = "VideoProcessInput", dead_letter_queue = false, is_fifo = false},
    {name = "VideoProcessOutput", dead_letter_queue = false, is_fifo = false},
  ]
}

module "s3" {
  source = "./modules/s3"
  bucket_name = "frameshot"
  notification_queue_arn =  module.sqs.queue_arns.S3Notifications
  notification_queue_url = module.sqs.queue_urls.S3Notifications
  depends_on = [ module.sqs ]
}

module "vpc" {  
    source = "./modules/vpc_app"
    vpc_name = "frameshot-vpc"
    azs = ["us-east-1a", "us-east-1b", "us-east-1c"]
    private_subnets = local.private_subnets_ip_bock
    public_subnets = local.public_subnets_ip_bock
}

module "aurora" {
    source = "./modules/aurora"
    vpc_id = module.vpc.vpc_id
    private_subnets = module.vpc.private_subnets
    private_subnets_cidr_block = local.private_subnets_ip_bock
    cluster_identifier = "frameshot-aurora-cluster"
    db_master_username = var.db_master_username
    db_master_password = var.db_master_password
    database_name = var.db_name

    depends_on = [ module.vpc ]
}

module "ecr" {
  source = "./modules/ecr"
  repositories = ["frameshot-api", "frameshot-app"]
}

module "ecs" {
  source = "./modules/ecs"
  cluster_name = "frameshot-cluster"
  private_subnets = module.vpc.private_subnets
  vpc_id = module.vpc.vpc_id
  api_ecr_url = module.ecr.repository_urls.frameshot-api
  app_ecr_url = module.ecr.repository_urls.frameshot-app

  depends_on = [ module.vpc, module.ecr ]
}

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_session_token" {}
variable "aws_region" {}
variable "db_master_username" {}
variable "db_master_password" {}
variable "db_name" {}