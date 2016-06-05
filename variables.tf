variable "public_key_path" {
  description = <<DESCRIPTION
Path to an existing SSH public key to be used for authentication.
Ensure this keypair is added to your local SSH agent so provisioners can
connect.

Example: ~/.ssh/terraform.pub
DESCRIPTION
}

variable "aws_credentials_file" {
  description = <<DESCRIPTION
Path to the AWS shared credentials file.

See https://blogs.aws.amazon.com/security/post/Tx3D6U6WSFGOK2H/A-New-and-Standardized-Way-to-Manage-Credentials-in-the-AWS-SDKs for more information.

Example: /Users/user/.aws/credentials
DESCRIPTION
  default = "/Users/tuppa/.aws/credentials"
}

variable "key_name" {
  description = "Desired name of AWS key pair"
  default = "flask"
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default = "ap-southeast-2"
}

# Ubuntu Trusty 14.04 LTS (x64)
variable "aws_amis" {
  default = {
    eu-west-1 = "ami-752dbe06"
    us-east-1 = "ami-7925d914"
    us-west-1 = "ami-8c1268ec"
    us-west-2 = "ami-1733cb77"
    ap-northeast-1 = "ami-7a0fe01b"
    ap-southeast-1 = "ami-72ac7c11"
    ap-southeast-2 = "ami-aec9e7cd"
    sa-east-1 = "ami-7d50db11"
    eu-central-1 = "ami-0b907e64"
  }
}

variable "instance_type" {
  description = "Instance type for Flask instance"
  default = "t2.micro"
}
