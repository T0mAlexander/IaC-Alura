resource "aws_lb" "app-lb" {
  name = "ECS-Django"
  security_groups = [aws_security_group.tcp-alb.id]
  subnets         = module.vpc.public_subnets
}

resource "aws_lb_target_group" "ecs-alvo" {
  name        = "ECS-Django"
  port        = 8000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app-lb.arn
  port              = "8000"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs-alvo.arn
  }
}

output "IP" {
  value = aws_lb.app-lb.dns_name
}