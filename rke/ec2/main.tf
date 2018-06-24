provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_security_group" "allow_all" {
  name        = "${var.rke_cluster_name}-allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = "${var.aws_vpc_id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

data "template_file" "userdata" {
  template = "${file("${path.module}/files/userdata.template")}"

  vars {
    docker_version = "${var.docker_version}"
    rhel_selinux = "${var.rhel_selinux}"
    rhel_docker_native = "${var.rhel_docker_native}"
  }
}

resource "aws_instance" "rke_all_role" {
  ami           = "${var.aws_ami}"
  instance_type = "${var.aws_instance_type}"
  key_name      = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
  user_data = "${data.template_file.userdata.rendered}"
  tags {
    Name = "${var.rke_cluster_name}-all-role"
  }
}
