variable "env_name" {}

variable "availability_zones" {
  type = "list"
}

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

variable "zone_id" {}

variable "dns_suffix" {}

variable "public_subnet_ids" {}

# ==== CERTS ===================================================================

variable "ssl_cert_arn" {
  type        = "string"
  description = "The ARN for the certificate to be used by the LB, optional if `ssl_cert` or `ssl_ca_cert` is provided"
  default     = ""
}

variable "ssl_cert" {
  type        = "string"
  description = "the contents of an SSL certificate to be used by the LB, optional if `ssl_cert_arn` or `ssl_ca_cert` is provided"
  default     = ""
}

variable "ssl_private_key" {
  type        = "string"
  description = "the contents of an SSL private key to be used by the LB, optional if `ssl_cert_arn` or `ssl_ca_cert` is provided"
  default     = ""
}

variable "ssl_ca_cert" {
  type        = "string"
  description = "the contents of a CA public key to be used to sign the generated LB certificate, optional if `ssl_cert_arn` or `ssl_cert` is provided"
  default     = ""
}

variable "ssl_ca_private_key" {
  type        = "string"
  description = "the contents of a CA private key to be used to sign the generated LB certificate, optional if `ssl_cert_arn` or `ssl_cert` is provided"
  default     = ""
}

# ==== ISOLATION GROUPS ========================================================
variable "isoseg_ssl_ca_private_key" {
  type        = "string"
  description = "the contents of a CA private key to be used to sign the generated iso seg LB certificate, optional if `isoseg_ssl_cert` is provided"
  default     = ""
}

variable "isoseg_ssl_ca_cert" {
  type        = "string"
  description = "the contents of a CA public key to be used to sign the generated iso seg LB certificate, optional if `isoseg_ssl_cert` is provided"
  default     = ""
}

variable "isoseg_ssl_private_key" {
  type        = "string"
  description = "the contents of an SSL private key to be used by the LB, optional if `isoseg_ssl_ca_cert` is provided"
  default     = ""
}

variable "isoseg_ssl_cert" {
 type        = "string"
 description = "the contents of an SSL certificate to be used by the LB, optional if `isoseg_ssl_ca_cert` is provided"
 default     = ""
}

variable "create_isoseg_resources" {
 type        = "string"
 default     = "0"
 description = "Optionally create a LB and DNS entries for a single isolation segment. Valid values are 0 or 1."
}

# ==============================================================================


locals {
  pas_cidr        = "${cidrsubnet(var.vpc_cidr, 6, 1)}"
  services_cidr   = "${cidrsubnet(var.vpc_cidr, 6, 2)}"
}
