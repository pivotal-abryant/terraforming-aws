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

variable "env_name" {}

variable "availability_zones" {
  type = "list"
}

variable "vpc_cidr" {}

variable "vpc_id" {}

variable "tags" {
  type = "map"
}

locals {
  rds_cidr = "${cidrsubnet(var.vpc_cidr, 6, 3)}"
}
