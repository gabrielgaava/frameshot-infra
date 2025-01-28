data "aws_vpc" "existing_vpc" {
  id = var.vpc_id
}

resource "aws_security_group" "sg_for_aurora" {
  vpc_id = data.aws_vpc.existing_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "aurora-security-group"
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "aurora-subnet-group"
  subnet_ids = var.private_subnets

  tags = {
    Name = "aurora-subnet-group"
  }
}

resource "aws_rds_cluster" "serverless_aurora_pg" {
  engine             = "aurora-postgresql"
  engine_version     = "13.12"
  cluster_identifier = var.cluster_identifier
  master_username    = var.db_master_username
  master_password    = var.db_master_password
  skip_final_snapshot = true
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.sg_for_aurora.id]
  database_name      = var.database_name
  engine_mode        = "provisioned"

  scaling_configuration {
    min_capacity = 2
    max_capacity = 4
    auto_pause   = true
    seconds_until_auto_pause = 1800  
  }

  tags = {
    Name = "serverless_aurora_pg"
  }
}