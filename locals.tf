resource "random_integer" "bucket" {
  min = 1
  max = 100000
}

locals {
  bucket_suffix = "${random_integer.bucket.result}"

  default_tags = {
    Environment = "${var.env_name}"
    Application = "Cloud Foundry"
  }

  actual_tags = "${merge(var.tags, local.default_tags)}"
}
