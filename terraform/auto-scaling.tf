resource "aws_autoscaling_group" "grupo" {
  name = "escalonamento-ec2"
  availability_zones = [ "${var.sao-paulo}" ]
  min_size = var.autoscale_min
  max_size = var.autoscale_max

  launch_template {
    id = aws_launch_template.maquina.id
    version = "$Latest"
  }
}