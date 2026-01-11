##############################################
# Get latest Debian Linux AMI with Terraform #
##############################################


data "aws_ami" "server_ami" {
  most_recent = true
  owners      = var.ami_owners

  filter {
    name   = "name"
    values = [var.ami_filter_name]
  }

  # filter {
  #   name   = "virtualization-type"
  #   values = ["hvm"]
  # }
}

# Debian 13 Trixie
# data "aws_ami" "debian-13" {
#   most_recent = true
#   owners      = ["136693071363", "000000000000", "self"]

#   filter {
#     name   = "name"
#     values = ["debian-13-amd64-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
# }

# # Debian 12 Bookworm
# data "aws_ami" "debian-12" {
#   most_recent = true
#   owners = ["136693071363"]

#   filter {
#     name   = "name"
#     values = ["debian-12-amd64-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
# }