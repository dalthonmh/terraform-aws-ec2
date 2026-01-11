###################################
## Virtual Machine Module - Main ##
###################################

# 1. Networking Module
module "networking" {
  source          = "../../modules/networking"

  app_name        = var.app_name
  app_environment = var.app_environment
}

# 2. Security Module (Depends on networking for VPC ID)
module "security" {
  source          = "../../modules/security"

  app_name        = var.app_name
  app_environment = var.app_environment
  aws_region      = var.aws_region
  vpc_id          = module.networking.vpc_id
}

# 3. EC2 Instance Module (Depends on Networking and Security)
module "ec2-instance" {
  source = "../../modules/ec2-instance"
  
  # Metadata
  app_name        = var.app_name
  app_environment = var.app_environment

  # AMI Selection
  ami_filter_name = var.ami_filter_name
  ami_owners      = var.ami_owners

  # Network & Security
  subnet_id         = module.networking.public_subnet_id
  security_group_id = module.security.security_group_id
  key_name          = module.security.key_name

  # Instance Specs
  linux_instance_type               = var.linux_instance_type
  linux_associate_public_ip_address = var.linux_associate_public_ip_address
  linux_root_volume_size            = var.linux_root_volume_size
  linux_data_volume_size            = var.linux_data_volume_size
  linux_root_volume_type            = var.linux_root_volume_type
  linux_data_volume_type            = var.linux_data_volume_type
}
