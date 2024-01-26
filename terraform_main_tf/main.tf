provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "example" {
  ami           = "ami-09024b009ae9e7adf" # Dies ist ein Beispiel-AMI für eu-central-1. Ersetze diesen Wert durch einen gültigen AMI für deine Region.
  instance_type = "t2.micro"

  tags = {
    Name = "Terraform-Example"
  }
}
