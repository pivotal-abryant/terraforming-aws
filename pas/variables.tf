variable "env_name" {}

variable "availability_zones" {}

variable "vpc_cidr" {}

variable "vpc_id" {}

variable "private_route_table_ids" {}

variable "bucket_suffix" {}

variable "create_backup_pas_buckets" {
  default = false
}

variable "create_versioned_pas_buckets" {
  default = false
}

variable "blobstore_kms_key_arn" {}

variable "ops_manager_iam_user_name" {}

variable "iam_ops_manager_role_name" {}

variable "tags" {
  type = "map"
}

locals {
  pas_cidr        = "${cidrsubnet(var.vpc_cidr, 6, 1)}"
  services_cidr   = "${cidrsubnet(var.vpc_cidr, 6, 2)}"
}
