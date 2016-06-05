# Prerequisite
1. Review variables.tf and modify any Terraform variables as necessary.
2. Setup AWS credentials file as per https://blogs.aws.amazon.com/security/post/Tx3D6U6WSFGOK2H/A-New-and-Standardized-Way-to-Manage-Credentials-in-the-AWS-SDKs. As an example:
```
$ cat ~/.aws/aws_credentials_file
AWSAccessKeyId=<access key goes here>
AWSSecretKey=<secret key goes here>
```

# To provision
1. Run terraform first to launch the necessary AWS resources
```
terraform apply
```

2. Run ansible
```
ansible-playbook -i hosts flask.yml
```
