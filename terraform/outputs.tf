output "deployment_server_ip" {
  value = aws_instance.devsecops_server.public_ip
}
