resource "aws_autoscaling_group" "grupo_auto_scale" {
  availability_zones = [var.sao-paulo, var.sao-paulo-c]
  name               = var.nome_do_agrupamento
  max_size           = var.autoscale_max
  min_size           = var.autoscale_min

  launch_template {
    id      = aws_launch_template.maquina.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.alvo-lb.arn]
}
