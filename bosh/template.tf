resource "aws_kms_key" "blobstore_kms_key" {
  description             = "${var.env_name} KMS key"
  deletion_window_in_days = 7

  tags = "${merge(var.tags, var.default_tags,
    map("Name", "${var.env_name} Blobstore KMS Key")
  )}"
}

resource "aws_kms_alias" "blobstore_kms_key_alias" {
  name          = "alias/${var.env_name}"
  target_key_id = "${aws_kms_key.blobstore_kms_key.key_id}"
}
