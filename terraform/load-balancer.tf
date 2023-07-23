resource "aws_lb" "load-balancer" {
  internal        = false
  security_groups = [aws_security_group.global-security-group.id]
  subnets         = [aws_default_subnet.subnet_1.id, aws_default_subnet.subnet_2.id]

  count = var.prod ? 1 : 0
}

resource "aws_lb_target_group" "alvo-lb" {
  name     = "Maquinas-Alvo"
  port     = "8000"
  protocol = "HTTP"
  vpc_id   = aws_default_vpc.vpc-padrao.id
  count    = var.prod ? 1 : 0
}

resource "aws_lb_listener" "entrada-lb" {
  load_balancer_arn = aws_lb.load-balancer[count.index].arn
  port              = "8000"
  protocol          = "HTTP"
  count             = var.prod ? 1 : 0

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alvo-lb[count.index].arn
  }
}
