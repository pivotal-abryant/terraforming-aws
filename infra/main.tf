resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc_cidr}"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = "${merge(var.tags, var.default_tags,
    map("Name", "${var.env_name}-vpc")
  )}"
}

resource "aws_security_group" "vms_security_group" {
  name        = "vms_security_group"
  description = "VMs Security Group"
  vpc_id      = "${aws_vpc.vpc.id}"

  ingress {
    cidr_blocks = ["${var.vpc_cidr}"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }

  tags = "${merge(var.tags, var.default_tags,
    map("Name", "${var.env_name}-vms-security-group")
  )}"
}

resource "aws_security_group" "nat_security_group" {
  name        = "nat_security_group"
  description = "NAT Security Group"
  vpc_id      = "${var.vpc_id}"

  ingress {
    cidr_blocks = ["${var.vpc_cidr}"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }

  tags = "${merge(var.tags, var.default_tags,
    map("Name", "${var.env_name}-nat-security-group")
  )}"
}

resource "aws_instance" "nat" {
  ami                    = "${lookup(var.nat_ami_map, var.region)}"
  instance_type          = "t2.medium"
  vpc_security_group_ids = ["${aws_security_group.nat_security_group.id}"]
  source_dest_check      = false
  subnet_id              = "${var.public_subnet_id}"

  tags = "${merge(var.tags, var.default_tags,
    map("Name", "${var.env_name}-nat")
  )}"
}

resource "aws_eip" "nat_eip" {
  instance = "${aws_instance.nat.id}"
  vpc      = true

  tags = "${merge(var.tags, var.default_tags)}"
}

resource "aws_route_table" "private_route_table" {
  count  = "${length(var.availability_zones)}"
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block  = "0.0.0.0/0"
    instance_id = "${aws_instance.nat.id}"
  }
}
