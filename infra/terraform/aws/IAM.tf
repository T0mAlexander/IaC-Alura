resource "aws_iam_role" "cargo" {
  name = "${var.cargo_iam}_cargo"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = ["ec2.amazonaws.com", "ecs-tasks.amazonaws.com"]
        },
      },
    ]
  })
}

resource "aws_iam_role_policy" "ecs_ecr" {
  name = "test_policy"
  role = aws_iam_role.cargo.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_instance_profile" "perfil" {
  name = "${var.cargo_iam}_perfil"
  role = aws_iam_role.cargo.name
}