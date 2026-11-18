# Terraform Configuration untuk RDS Database
# Gunakan ini untuk membuat RDS instance di AWS Asli atau LocalEmu

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Provider Configuration
provider "aws" {
  # Gunakan profile "local" untuk LocalEmu
  # Gunakan profile "default" untuk AWS asli
  profile = "local"
  region  = "us-east-1"

  # Endpoint untuk LocalEmu (hanya jika menggunakan emulator)
  # Comment out jika menggunakan AWS asli
  endpoints {
    rds = "http://localhost:4566"
  }

  # Skip credential validation untuk LocalEmu
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
}

# RDS Instance
resource "aws_db_instance" "lambda_rds" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_name              = "lambda_db"
  username             = "admin"
  password             = "changeme123"  # Ganti dengan password yang kuat!
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true  # True untuk LocalEmu, False untuk production

  # Security Group
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  tags = {
    Name        = "lambda-rds-instance"
    Environment = "development"
    Project     = "aws-lambda-practicum"
  }
}

# Security Group untuk RDS
resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Security group for RDS instance"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Dalam production, batasi ke IP tertentu
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}

# Output
output "rds_endpoint" {
  description = "RDS instance endpoint"
  value       = aws_db_instance.lambda_rds.endpoint
}

output "rds_port" {
  description = "RDS instance port"
  value       = aws_db_instance.lambda_rds.port
}

output "db_name" {
  description = "Database name"
  value       = aws_db_instance.lambda_rds.db_name
}
