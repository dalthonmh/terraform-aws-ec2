output "instance_id" {
  value = aws_instance.linux-server.id
}

output "server_public_ip" {
  description = "Public IP from the Elastic IP"
  value       = aws_eip.linux-eip.public_ip
}

output "vm_linux_server_instance_public_dns" {
  description = "Public DNS from the Elastic IP"
  value       = aws_eip.linux-eip.public_dns
}