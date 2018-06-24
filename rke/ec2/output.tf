output "public_ip" {
  value = "${aws_instance.rke_all_role.public_ip}"
}

output "private_ip" {
  value = "${aws_instance.rke_all_role.private_ip}"
}
