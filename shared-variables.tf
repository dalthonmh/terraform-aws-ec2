##############################################
## Stack Module - Shared Variables          ##
##############################################

variable "app_name" {
  type        = string
  description = "Application name"
}

variable "app_environment" {
  type        = string
  description = "Application environment"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "aws_az" {
  type        = string
  description = "AWS Availability Zone"
  default     = "us-east-1a"
}