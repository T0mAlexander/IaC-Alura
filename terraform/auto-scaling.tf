resource "aws_autoscaling_group" "grupo_auto_scale" {
  availability_zones = [var.sao-paulo, var.sao-paulo-c]
  name               = var.nome_do_agrupamento
  max_size           = var.autoscale_max
  min_size           = var.autoscale_min
  count = var.prod ? 1 : 0

  launch_template {
    id      = aws_launch_template.maquina.id
    version = "$Latest"
  }

  target_group_arns = var.prod ? [aws_lb_target_group.alvo-lb[count.index].arn] : []

}

resource "aws_autoscaling_policy" "escala-prod" {
  name                   = "terraform-escala"
  autoscaling_group_name = aws_autoscaling_group.grupo_auto_scale[count.index].id
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization" // Consumo médio da CPU
    }

    target_value = 50.0 // Taxa de consumo da CPU
  }

  count = var.prod ? 1 : 0
}