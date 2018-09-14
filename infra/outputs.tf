output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "infrastructure_subnet_ids" {
  value = ["${aws_subnet.infrastructure_subnets.*.id}"]
}

output "public_subnet_ids" {
  value = ["${aws_subnet.public_subnets.*.id}"]
}

output "private_route_table_ids" {
  value = ["${aws_route_table.private_route_table.*.id}"]
}
