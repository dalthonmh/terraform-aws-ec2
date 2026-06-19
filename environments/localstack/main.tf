###################################
## EC2 Stack - Main                ##
###################################

module "stack" {
  source = "../.."

  app_name        = var.app_name
  app_environment = var.app_environment
  aws_region      = var.aws_region
  aws_az          = var.aws_az

  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr

  ami_filter_name = var.ami_filter_name
  ami_owners      = var.ami_owners

  linux_instance_type               = var.linux_instance_type
  linux_associate_public_ip_address = var.linux_associate_public_ip_address
  linux_root_volume_size            = var.linux_root_volume_size
  linux_data_volume_size            = var.linux_data_volume_size
  linux_root_volume_type            = var.linux_root_volume_type
  linux_data_volume_type            = var.linux_data_volume_type
}