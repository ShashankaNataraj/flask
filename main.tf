provider "aws" {
  region = "${var.aws_region}"
  shared_credentials_file = "${var.aws_credentials_file}"
  profile = "default"
}

resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"
}

resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.default.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.default.id}"
}

resource "aws_subnet" "default" {
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_security_group" "flasksg" {
  name        = "flask"
  description = "Flask instance default SG"
  vpc_id      = "${aws_vpc.default.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "sg_allow_ssh" {
  type = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.flasksg.id}"
}

resource "aws_security_group_rule" "sg_allow_http" {
  type = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.flasksg.id}"
}


resource "aws_key_pair" "auth" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_eip" "eip" {
  vpc = true
  instance = "${aws_instance.flask.id}"
  provisioner "local-exec" {
    command = "echo \"[flask]\" > hosts; echo ${aws_eip.eip.public_ip} >> hosts"
  }
}

resource "aws_instance" "flask" {
  connection {
    user = "ubuntu"
  }

  tags {
    Name = "Flask"
  }

  instance_type = "${var.instance_type}"
  ami = "${lookup(var.aws_amis, var.aws_region)}"
  key_name = "${aws_key_pair.auth.id}"
  vpc_security_group_ids = ["${aws_security_group.flasksg.id}"]
  subnet_id = "${aws_subnet.default.id}"

}
