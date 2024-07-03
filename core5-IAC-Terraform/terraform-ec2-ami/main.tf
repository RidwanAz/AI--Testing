provider "aws" {
  region = "us-east-1"  # Change this to your desired AWS region
}

resource "aws_instance" "example_instance" {
  ami           = "ami-0c55b159cbfafe1f0"  # Specify your desired AMI ID
  instance_type = "t2.micro"
  key_name      = "your-key-pair"  # Specify your key pair name

  // Add other necessary configuration for your instance (e.g., subnet, security group, etc.)
}

resource "aws_ami" "example_ami" {
  name        = "example-ami"
  description = "Example AMI created with Terraform"
  instance_id = aws_instance.example_instance.id

  // Add any additional settings or configuration for your AMI
}
