output "public_address" {
  value = "${aws_eip.eip.public_ip}"
}

output "private_address" {
  value = "${aws_instance.flask.private_ip}"
}
