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

variable "dns_suffix" {
}

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

/*****************************
 * Isolation Segment Options *
 *****************************/

variable "isoseg_ssl_cert" {
  type        = "string"
  description = "the contents of an SSL certificate to be used by the LB, optional if `isoseg_ssl_ca_cert` is provided"
  default     = ""
}

variable "isoseg_ssl_private_key" {
  type        = "string"
  description = "the contents of an SSL private key to be used by the LB, optional if `isoseg_ssl_ca_cert` is provided"
  default     = ""
}

variable "isoseg_ssl_ca_cert" {
  type        = "string"
  description = "the contents of a CA public key to be used to sign the generated iso seg LB certificate, optional if `isoseg_ssl_cert` is provided"
  default     = ""
}

variable "isoseg_ssl_ca_private_key" {
  type        = "string"
  description = "the contents of a CA private key to be used to sign the generated iso seg LB certificate, optional if `isoseg_ssl_cert` is provided"
  default     = ""
}

variable "create_isoseg_resources" {
  type        = "string"
  default     = "0"
  description = "Optionally create a LB and DNS entries for a single isolation segment. Valid values are 0 or 1."
}

locals {
  public_cidr = "${cidrsubnet(var.vpc_cidr, 6, 0)}"
}
