provider "aws" {
  region = "eu-central-1"
}

resource "aws_iam_policy" "terraform_policy" {
  name        = "TerraformEC2Policy"
  path        = "/"
  description = "Policy for EC2 Terraform Node"

  # Hier fügst du die JSON-Policy ein, die du aus der policy.txt erstellt hast.
  policy = file("policy.json")
}

resource "aws_iam_role" "terraform_role" {
  name = "TerraformEC2Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "terraform_attach" {
  role       = aws_iam_role.terraform_role.name
  policy_arn = aws_iam_policy.terraform_policy.arn
}

resource "aws_iam_instance_profile" "terraform_instance_profile" {
  name = "TerraformEC2InstanceProfile"
  role = aws_iam_role.terraform_role.name
}

