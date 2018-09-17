locals {
  ops_man_subnet_id = "${var.ops_manager_private ? element(module.infra.infrastructure_subnet_ids, 0) : element(module.infra.public_subnet_ids, 0)}"
}

module "infra" {
  source             = "./infra"

  env_name           = "${var.env_name}"
  region             = "${var.region}"
  availability_zones = "${var.availability_zones}"
  vpc_cidr           = "${var.vpc_cidr}"

  hosted_zone        = "${var.hosted_zone}"
  dns_suffix         = "${var.dns_suffix}"

  tags               = "${local.actual_tags}"
}

module "ops_manager" {
  source = "./ops_manager"

  count          = "${var.ops_manager ? 1 : 0}"
  optional_count = "${var.optional_ops_manager ? 1 : 0}"
  subnet_id      = "${local.ops_man_subnet_id}"

  env_name                  = "${var.env_name}"
  ami                       = "${var.ops_manager_ami}"
  optional_ami              = "${var.optional_ops_manager_ami}"
  instance_type             = "${var.ops_manager_instance_type}"
  private                   = "${var.ops_manager_private}"
  vpc_id                    = "${module.infra.vpc_id}"
  vpc_cidr                  = "${var.vpc_cidr}"
  dns_suffix                = "${var.dns_suffix}"
  zone_id                   = "${module.infra.zone_id}"
  iam_ops_manager_user_name = "${aws_iam_user.ops_manager.name}"
  iam_ops_manager_role_name = "${aws_iam_role.ops_manager.name}"
  iam_ops_manager_role_arn  = "${aws_iam_role.ops_manager.arn}"
  iam_pas_bucket_role_arn   = "${module.pas.iam_pas_bucket_role_arn}"
  bucket_suffix             = "${local.bucket_suffix}"
  instance_profile_name     = "${aws_iam_instance_profile.ops_manager.name}"
  instance_profile_arn      = "${aws_iam_instance_profile.ops_manager.arn}"

  tags                      = "${local.actual_tags}"
}

module "bosh" {
  source = "./bosh"

  env_name           = "${var.env_name}"

  tags               = "${local.actual_tags}"
}

module "pas" {
  source = "./pas"

  env_name                  = "${var.env_name}"
  availability_zones        = "${var.availability_zones}"
  vpc_cidr                  = "${var.vpc_cidr}"
  vpc_id                    = "${module.infra.vpc_id}"
  private_route_table_ids   = "${module.infra.private_route_table_ids}"
  bucket_suffix             = "${local.bucket_suffix}"
  blobstore_kms_key_arn     = "${module.bosh.blobstore_kms_key_arn}"
  ops_manager_iam_user_name = "${aws_iam_user.ops_manager.name}"
  iam_ops_manager_role_name = "${aws_iam_role.ops_manager.name}"

  public_subnet_ids         = "${module.infra.public_subnet_ids}"
  dns_suffix                = "${var.dns_suffix}"
  zone_id                   = "${module.infra.zone_id}"

  tags                      = "${local.actual_tags}"
}

module "rds" {
  source = "./rds"

  rds_db_username    = "${var.rds_db_username}"
  rds_instance_class = "${var.rds_instance_class}"
  rds_instance_count = "${var.rds_instance_count}"

  env_name           = "${var.env_name}"
  availability_zones = "${var.availability_zones}"
  vpc_cidr           = "${var.vpc_cidr}"
  vpc_id             = "${module.infra.vpc_id}"

  tags               = "${local.actual_tags}"
}
