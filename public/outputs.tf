output "public_subnet_ids" {
  value = ["${aws_subnet.public_subnets.*.id}"]
}

output "public_subnets" {
  value = ["${aws_subnet.public_subnets.*.id}"]
}

output "public_subnet_availability_zones" {
  value = ["${aws_subnet.public_subnets.*.availability_zone}"]
}

output "public_subnet_cidrs" {
  value = ["${aws_subnet.public_subnets.*.cidr_block}"]
}

output "ssl_cert_arn" {
  value = "${var.ssl_cert_arn}"
}

output "ssl_cert" {
  sensitive = true
  value     = "${length(var.ssl_ca_cert) > 0 ? element(concat(tls_locally_signed_cert.ssl_cert.*.cert_pem, list("")), 0) : var.ssl_cert}"
}

output "ssl_private_key" {
  sensitive = true
  value     = "${length(var.ssl_ca_cert) > 0 ? element(concat(tls_private_key.ssl_private_key.*.private_key_pem, list("")), 0) : var.ssl_private_key}"
}

output "isoseg_ssl_cert" {
  sensitive = true
  value     = "${length(var.isoseg_ssl_ca_cert) > 0 ? element(concat(tls_locally_signed_cert.isoseg_ssl_cert.*.cert_pem, list("")), 0) : var.isoseg_ssl_cert}"
}

output "isoseg_ssl_private_key" {
  sensitive = true
  value     = "${length(var.isoseg_ssl_ca_cert) > 0 ? element(concat(tls_private_key.isoseg_ssl_private_key.*.private_key_pem, list("")), 0) : var.isoseg_ssl_private_key}"
}

output "ssh_elb_name" {
  value = "${aws_elb.ssh_elb.name}"
}

output "tcp_lb_name" {
  value = "${aws_elb.tcp_elb.name}"
}

output "tcp_elb_name" {
  value = "${aws_elb.tcp_elb.name}"
}

output "isoseg_elb_name" {
  value = "${element(concat(aws_elb.isoseg.*.name, list("")), 0)}"
}

output "web_lb_name" {
  value = "${aws_elb.web_elb.name}"
}

output "ssh_lb_name" {
  value = "${aws_elb.ssh_elb.name}"
}


output "web_elb_name" {
  value = "${aws_elb.web_elb.name}"
}
