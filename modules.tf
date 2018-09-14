locals {
  ops_man_subnet_id = "${var.ops_manager_private ? element(module.bosh.infrastructure_subnet_ids, 0) : element(module.public.public_subnet_ids, 0)}"
}

module "infra" {
  source = "./infra"

  env_name  = "${var.env_name}"
  tags      = "${var.tags}"
  vpc_cidr  = "${var.vpc_cidr}"

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
  vpc_id                    = "${aws_vpc.vpc.id}"
  vpc_cidr                  = "${var.vpc_cidr}"
  dns_suffix                = "${var.dns_suffix}"
  zone_id                   = "${local.zone_id}"
  iam_ops_manager_user_name = "${aws_iam_user.ops_manager.name}"
  iam_ops_manager_role_name = "${aws_iam_role.ops_manager.name}"
  iam_ops_manager_role_arn  = "${aws_iam_role.ops_manager.arn}"
  iam_pas_bucket_role_arn   = "${module.pas.iam_pas_bucket_role_arn}"
  bucket_suffix             = "${local.bucket_suffix}"
  instance_profile_name     = "${aws_iam_instance_profile.ops_manager.name}"
  instance_profile_arn      = "${aws_iam_instance_profile.ops_manager.arn}"
  tags                      = "${var.tags}"
  default_tags              = "${local.default_tags}"
}

module "bosh" {
  source = "./bosh"

  region             = "${var.region}"
  availability_zones = "${var.availability_zones}"
  env_name           = "${var.env_name}"
  tags               = "${var.tags}"
  vpc_cidr           = "${var.vpc_cidr}"
  vpc_id             = "${aws_vpc.vpc.id}"
  default_tags       = "${local.default_tags}"
  public_subnet_id   = "${element(module.public.public_subnet_ids, 0)}"
}

module "pas" {
  source = "./pas"

  availability_zones        = "${var.availability_zones}"
  env_name                  = "${var.env_name}"
  tags                      = "${var.tags}"
  vpc_cidr                  = "${var.vpc_cidr}"
  vpc_id                    = "${aws_vpc.vpc.id}"
  default_tags              = "${local.default_tags}"
  private_route_table_ids   = "${module.bosh.private_route_table_ids}"
  bucket_suffix             = "${local.bucket_suffix}"
  blobstore_kms_key_arn     = "${module.bosh.blobstore_kms_key_arn}"
  ops_manager_iam_user_name = "${aws_iam_user.ops_manager.name}"
  iam_ops_manager_role_name = "${aws_iam_role.ops_manager.name}"
}

module "rds" {
  source = "./rds"

  availability_zones = "${var.availability_zones}"
  env_name           = "${var.env_name}"
  tags               = "${var.tags}"
  vpc_cidr           = "${var.vpc_cidr}"
  vpc_id             = "${aws_vpc.vpc.id}"
  default_tags       = "${local.default_tags}"
}

module "public" {
  source = "./public"

  availability_zones = "${var.availability_zones}"
  env_name           = "${var.env_name}"
  tags               = "${var.tags}"
  vpc_cidr           = "${var.vpc_cidr}"
  vpc_id             = "${aws_vpc.vpc.id}"
  default_tags       = "${local.default_tags}"
  dns_suffix         = "${var.dns_suffix}"

}
