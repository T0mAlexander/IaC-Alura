output "ips" {
  value = ["${aws_instance.server.public_ip}, ${aws_instance.prod.public_ip}"]
}