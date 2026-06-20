########################################
## Virtual Machine Module - Variables ##
########################################

# ----------------- General variables  -----------------

variable "app_name" {
  type        = string
  description = "Application name"
  default     = "todoapp"
}

variable "app_environment" {
  type        = string
  description = "Application environment"
  default     = "stage"
}

# ---------- AWS connection & authentication -----------

variable "aws_access_key" {
  type        = string
  description = "AWS access key"
}

variable "aws_secret_key" {
  type        = string
  description = "AWS secret key"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "aws_az" {
  type        = string
  description = "AWS Availability Zone (e.g. us-east-1a, not the region)"
  default     = "us-east-1a"
}

# ------------ Network Single AZ Public Only -----------

variable "vpc_cidr" {
  type        = string
  description = "CIDR for the VPC"
  default     = "10.1.64.0/18"
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR for the public subnet"
  default     = "10.1.64.0/24"
}

# --------------- Virtual Machine Module ---------------

variable "linux_instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t2.small"
}

variable "linux_associate_public_ip_address" {
  type        = bool
  description = "Associate a public IP address"
  default     = true
}

variable "linux_root_volume_size" {
  type        = number
  description = "Size of root volume in GB"
}

variable "linux_data_volume_size" {
  type        = number
  description = "Size of data volume in GB"
}

variable "linux_root_volume_type" {
  type        = string
  description = "Type of root volume (gp2, gp3, etc)"
  default     = "gp2"
}

variable "linux_data_volume_type" {
  type        = string
  description = "Type of data volume"
  default     = "gp2"
}

# ----------------- AMI Variables ----------------------

variable "ami_owners" {
  type        = list(string)
  description = "Oweners ID for debian, official and localstack"
  default     = ["136693071363"] 
}

variable "ami_filter_name" {
  type        = string
  description = "Name filter for debian AMI"
  default     = "debian-13-amd64-*" 
}
