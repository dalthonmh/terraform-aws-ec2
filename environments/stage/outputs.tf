output "vm_linux_server_instance_id" {
  description   = "Instance ID"
  value         = module.ec2-instance.instance_id
}

output "vm_linux_server_instance_public_ip" {
  description = "Public IP of the instance"
  value       = module.ec2-instance.server_public_ip
}

output "vm_linux_server_instance_public_dns" {
  description = "Public DNS of the instance"
  value       = module.ec2-instance.vm_linux_server_instance_public_dns
}