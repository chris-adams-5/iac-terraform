
resource "aws_iam_instance_profile" "task_listing_app_ec2_instance_profile" {
  name = "chris-tf-ec2-profile"
  role = aws_iam_role.role.name
  tags = {
    owner = "chris-ce"
  }
}


resource "aws_iam_role" "role" {
  name = "chris-task-listing-app-ec2-inst"

  // Allows the EC2 instances in our EB environment to assume (take on) this 
  // role.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            Action = "sts:AssumeRole"
            Principal = {
               Service = "ec2.amazonaws.com"
            }
            Effect = "Allow"
            Sid = ""
        }
    ]
  })
}

