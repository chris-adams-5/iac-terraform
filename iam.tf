
# Instance Profile
# Dont usually need to interact with this
# Container for a role so it can be passed to EC2

resource "aws_iam_instance_profile" "task_listing_app_ec2_instance_profile" {
  name = "chris-tf-ec2-profile"
  role = aws_iam_role.role.name
  tags = {
    owner = "chris-ce"
  }
}

# This is the policy document that 
# gets the ec2 to assume the role

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}


# The role
resource "aws_iam_role" "role" {
  name               = "chris-task-listing-app-ec2-inst"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

}

# attach policies to the role
resource "aws_iam_role_policy_attachment" "attach_web" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}
resource "aws_iam_role_policy_attachment" "attach_docker" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker"
}
resource "aws_iam_role_policy_attachment" "attach_worker" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWorkerTier"
}
resource "aws_iam_role_policy_attachment" "example_app_ec2_role_policy_attachment" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

