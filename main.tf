
provider "aws" {
  region = "eu-west-2"
}

resource "aws_ecr_repository" "ecr_repo" {
  name = "chris-tf-repo"

  tags = {
    owner = "chris-ce"
  }
}

resource "aws_s3_bucket" "docker_config" {
  bucket = "chris-tf-docker-config"
  tags = {
    owner = "chris-ce"
  }
}


resource "aws_elastic_beanstalk_application" "task_listing_app" {
  name        = "chris-task-listing-app"
  description = "Task listing app"
  tags = {
    owner = "chris-ce"
  }
}

resource "aws_elastic_beanstalk_environment" "task_listing_app_environment" {
  name        = "chris-task-listing-app-environment"
  application = aws_elastic_beanstalk_application.task_listing_app.name

  # This page lists the supported platforms
  # we can use for this argument:
  # https://docs.aws.amazon.com/elasticbeanstalk/latest/platforms/platforms-supported.html#platforms-supported.docker
  solution_stack_name = "64bit Amazon Linux 2023 v4.0.1 running Docker"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.task_listing_app_ec2_instance_profile.name
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = "chris-cloud-containers"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_HOST"
    value     = aws_db_instance.rds_app.address
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_USER"
    value     = aws_db_instance.rds_app.username
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_PASSWORD"
    value     = aws_db_instance.rds_app.password
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_DATABASE"
    value     = "postgres"
  }
}

resource "aws_db_instance" "rds_app" {
  allocated_storage   = 10
  engine              = "postgres"
  engine_version      = "18"
  instance_class      = "db.t3.micro"
  identifier          = "chris-tasklist-app-prod"
  username            = "root"
  password            = "password"
  skip_final_snapshot = true
  publicly_accessible = true
}