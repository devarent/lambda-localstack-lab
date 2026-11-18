# Terraform Configuration untuk EC2 Instance
# Gunakan ini untuk membuat EC2 instance di AWS Asli atau LocalEmu

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
    ec2 = "http://localhost:4566"
  }

  # Skip credential validation untuk LocalEmu
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
}

# EC2 Instance
resource "aws_instance" "lambda_ec2" {
  ami           = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2
  instance_type = "t2.micro"

  tags = {
    Name        = "lambda-ec2-instance"
    Environment = "development"
    Project     = "aws-lambda-practicum"
  }

  # Security Group
  vpc_security_group_ids = [aws_security_group.lambda_sg.id]
}

# Security Group
resource "aws_security_group" "lambda_sg" {
  name        = "lambda-security-group"
  description = "Security group for Lambda EC2 instance"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lambda-sg"
  }
}

# Output
output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.lambda_ec2.public_ip
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.lambda_ec2.id
}
