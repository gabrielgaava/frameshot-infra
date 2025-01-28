variable "cluster_identifier" {
  description = "Name of the cluster"
  type = string
}

variable "database_name" {
  description = "Name of the database"
  type = string
}

variable "db_master_username" {
  description = "The master username for the Aurora Serverless cluster."
  type        = string
}

variable "db_master_password" {
  description = "The master password for the Aurora Serverless cluster."
  type        = string
  sensitive   = true
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type = string
}

variable "private_subnets" {
  description = "The subnets used for the cluster"
  type = list(string)
}

variable "private_subnets_cidr_block" {
  description = "The subnets IP Blocks"
  type = list(string)
}