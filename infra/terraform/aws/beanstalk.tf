resource "aws_elastic_beanstalk_application" "app-beanstalk" {
  name        = var.nome
  description = var.descricao
}


resource "aws_elastic_beanstalk_environment" "env-beanstalk" {
  name                = var.ambiente
  application         = aws_elastic_beanstalk_application.app-beanstalk.name
  solution_stack_name = "64bit Amazon Linux 2 v3.5.9 running Docker"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.maquina
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = var.autoscale_max
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.beanstalk-ec2-profile.name
  }
}

resource "aws_elastic_beanstalk_application_version" "default" {
  depends_on = [
    aws_elastic_beanstalk_environment.env-beanstalk,
    aws_elastic_beanstalk_application.app-beanstalk
  ]

  name        = var.ambiente
  application = var.nome
  description = var.descricao
  bucket      = aws_s3_bucket.beanstalk-deploys.id
  key         = aws_s3_object.docker-configs.id
}