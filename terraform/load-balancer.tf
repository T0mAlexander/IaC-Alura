resource "aws_lb" "load-balancer" {
  internal = false
  security_groups = [ aws_security_group.global-security-group.id ]
  subnets  = [aws_default_subnet.subnet_1.id, aws_default_subnet.subnet_2.id]
}

resource "aws_lb_target_group" "alvo-lb" {
  name     = "Maquinas-Alvo"
  port     = "8000"
  protocol = "HTTP"
  vpc_id   = aws_default_vpc.vpc-padrao.id
}

resource "aws_lb_listener" "entrada-lb" {
  load_balancer_arn = aws_lb.load-balancer.arn
  port              = "8000"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alvo-lb.arn
  }
}