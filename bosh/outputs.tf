# output "private_route_table_ids" {
#   value = ["${aws_route_table.private_route_table.*.id}"]
# }
#
# output "infrastructure_subnet_ids" {
#   value = ["${aws_subnet.infrastructure_subnets.*.id}"]
# }
#
# output "infrastructure_subnets" {
#   value = ["${aws_subnet.infrastructure_subnets.*.id}"]
# }
#
# output "infrastructure_subnet_availability_zones" {
#   value = ["${aws_subnet.infrastructure_subnets.*.availability_zone}"]
# }
#
# output "infrastructure_subnet_cidrs" {
#   value = ["${aws_subnet.infrastructure_subnets.*.cidr_block}"]
# }
#
# output "infrastructure_subnet_gateways" {
#   value = ["${data.template_file.infrastructure_subnet_gateways.*.rendered}"]
# }
#
output "blobstore_kms_key_id" {
  value = "${aws_kms_key.blobstore_kms_key.key_id}"
}

output "blobstore_kms_key_arn" {
  value = "${aws_kms_key.blobstore_kms_key.arn}"
}
#
# # Deprecated ===================================================================
#
# output "management_subnet_ids" {
#   value = ["${aws_subnet.infrastructure_subnets.*.id}"]
# }
#
# output "management_subnets" {
#   value = ["${aws_subnet.infrastructure_subnets.*.id}"]
# }
#
# output "management_subnet_availability_zones" {
#   value = ["${aws_subnet.infrastructure_subnets.*.availability_zone}"]
# }
#
# output "management_subnet_cidrs" {
#   value = ["${aws_subnet.infrastructure_subnets.*.cidr_block}"]
# }
#
# output "management_subnet_gateways" {
#   value = ["${data.template_file.infrastructure_subnet_gateways.*.rendered}"]
# }
