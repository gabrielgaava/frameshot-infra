  variable "vpc_name" {
    description = "VPC Name."
    type        = string
  }
  
  variable "vpc_cidr_block" {
    description = "CIDR (Classless Inter-Domain Routing)."
    type        = string
    default     = "10.0.0.0/16"
  }
  
  variable "azs" {
    description = "Availability zones for subnets."
    type        = list(string)
  }
  
  variable "private_subnets" {
    description = "CIDR ranges for private subnets."
    type        = list(string)
  }
  
  variable "public_subnets" {
    description = "CIDR ranges for public subnets."
    type        = list(string)
  }