# Variables ====================================================================

variable "rds_db_username" {
  default = "admin"
}

variable "rds_instance_class" {
  default = "db.m4.large"
}

variable "rds_instance_count" {
  type    = "string"
  default = 0
}

variable "availability_zones" {
}

variable "env_name" {
}

variable "tags" {
}

variable "vpc_cidr" {
}

variable "vpc_id" {
}

variable "default_tags" {
}

locals {
  rds_cidr = "${cidrsubnet(var.vpc_cidr, 6, 3)}"
}

# Resources ====================================================================

resource "aws_subnet" "rds_subnets" {
  count             = "${length(var.availability_zones)}"
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${cidrsubnet(local.rds_cidr, 2, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"

  tags = "${merge(var.tags, var.default_tags,
    map("Name", "${var.env_name}-rds-subnet${count.index}")
  )}"
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name        = "${var.env_name}_db_subnet_group"
  description = "RDS Subnet Group"

  subnet_ids = ["${aws_subnet.rds_subnets.*.id}"]

  tags = "${merge(var.tags, var.default_tags,
    map("Name", "${var.env_name}-db-subnet-group")
  )}"
}

resource "aws_security_group" "mysql_security_group" {
  name        = "mysql_security_group"
  description = "MySQL Security Group"
  vpc_id      = "${var.vpc_id}"

  ingress {
    cidr_blocks = ["${var.vpc_cidr}"]
    protocol    = "tcp"
    from_port   = 3306
    to_port     = 3306
  }

  egress {
    cidr_blocks = ["${var.vpc_cidr}"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }

  tags = "${merge(var.tags, var.default_tags,
    map("Name", "${var.env_name}-mysql-security-group")
  )}"
}

resource "random_string" "rds_password" {
  length = 16
  special = false
}

resource "aws_db_instance" "rds" {
  allocated_storage      = 100
  instance_class         = "${var.rds_instance_class}"
  engine                 = "mariadb"
  engine_version         = "10.1.31"
  identifier             = "${var.env_name}"
  username               = "${var.rds_db_username}"
  password               = "${random_string.rds_password.result}"
  db_subnet_group_name   = "${aws_db_subnet_group.rds_subnet_group.name}"
  publicly_accessible    = false
  vpc_security_group_ids = ["${aws_security_group.mysql_security_group.id}"]
  iops                   = 1000
  multi_az               = true
  skip_final_snapshot    = true
  backup_retention_period = 7
  apply_immediately       = true

  count = "${var.rds_instance_count}"

  tags = "${merge(var.tags, var.default_tags)}"
}

# Outputs ======================================================================

output "rds_address" {
  value = "${element(concat(aws_db_instance.rds.*.address, list("")), 0)}"
}

output "rds_port" {
  value = "${element(concat(aws_db_instance.rds.*.port, list("")), 0)}"
}

output "rds_username" {
  value = "${element(concat(aws_db_instance.rds.*.username, list("")), 0)}"
}

output "rds_password" {
  sensitive = true
  value     = "${element(concat(aws_db_instance.rds.*.password, list("")), 0)}"
}
