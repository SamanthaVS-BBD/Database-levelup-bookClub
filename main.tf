variable "DB_USER" {}
variable "DB_PASSWORD" {}
variable "AWS_ACCESSKEY" {}
variable "AWS_SECRETKEY" {}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

# configured aws provider with proper credentials
provider "aws" {
  region  = "eu-west-1"
  access_key = var.AWS_ACCESSKEY
  secret_key = var.AWS_SECRETKEY
}


# creates default vpc if one does not exit
resource "aws_default_vpc" "bookClub_vpc" {

  tags = {
    Name = "bookClub vpc"
  }
}


data "aws_availability_zones" "available_zones" {}

resource "aws_default_subnet" "subnet_bookClub_a" {
  availability_zone = data.aws_availability_zones.available_zones.names[0]
}

resource "aws_default_subnet" "subnet_bookClub_b" {
  availability_zone = data.aws_availability_zones.available_zones.names[1]
}

# create security group for the database
resource "aws_security_group" "bookClub_security_group" {
  name        = "database security group"
  description = "enable mysql/aurora access on port 3306"
  vpc_id      = "vpc-0febd79e32a946d23"

  ingress {
    from_port        = 1433
    to_port          = 1433
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags   = {
    Name = "bookClub_security_group"
  }
}


# create the subnet group for the rds instance
resource "aws_db_subnet_group" "bookClub_subnet_group" {
  name         = "bookclubsubnetgroup"
  subnet_ids   = [aws_default_subnet.subnet_bookClub_a.id, aws_default_subnet.subnet_bookClub_b.id]

  tags   = {
    Name = "bookClub_subnet_group"
  }
}


# create the rds instance
resource "aws_db_instance" "bookclub_db_instance" {
  engine                  = "sqlserver-ex"
  multi_az                = false
  identifier              = "double-booked-db"
  username                = var.DB_USER
  password                = var.DB_PASSWORD
  instance_class          = "db.t3.small"
  allocated_storage       = 20
  publicly_accessible     = true
  db_subnet_group_name    = aws_db_subnet_group.bookClub_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.bookClub_security_group.id]
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  skip_final_snapshot     = true
}


