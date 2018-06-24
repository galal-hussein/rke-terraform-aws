data "terraform_remote_state" "ec2" {
  backend = "local"

  config {
   path = "${path.module}/../ec2/terraform.tfstate"
 }
}

data "template_file" "rke_tmpl" {
  template = "${file("${path.module}/files/rke.tmpl")}"
  vars {
    node_public_ip = "${data.terraform_remote_state.ec2.public_ip}"
    node_private_ip = "${data.terraform_remote_state.ec2.private_ip}"
    aws_ssh_priv_key_path = "${path.module}/../../genentech.pem"
    aws_ssh_user  = "${var.aws_ssh_user}"
  }
}

resource "local_file" "render_tpl_rke" {
    content     = "${data.template_file.rke_tmpl.rendered}"
    filename = "${path.module}/../../rke.yml"
}
