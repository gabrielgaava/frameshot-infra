data "aws_vpc" "existing_vpc" {
  id = var.vpc_id
}

resource "aws_security_group" "aurora_sg" {
  vpc_id = data.aws_vpc.existing_vpc.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = var.private_subnets_cidr_block
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "aurora_subnet_group" {
  name       = "aurora-subnet-group"
  subnet_ids = var.private_subnets
}

resource "aws_rds_cluster" "aurora_cluster" {
  engine             = "aurora-postgresql"
  engine_version     = "13.12"
  cluster_identifier = var.cluster_identifier
  master_username    = var.db_master_username
  master_password    = var.db_master_password
  skip_final_snapshot = true
  db_subnet_group_name = aws_db_subnet_group.aurora_subnet_group.name
  vpc_security_group_ids = [aws_security_group.aurora_sg.id]
  database_name      = var.database_name
}