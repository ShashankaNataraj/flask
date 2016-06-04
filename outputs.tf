output "address" {
  value = "${aws_eip.eip.public_ip}"
}
