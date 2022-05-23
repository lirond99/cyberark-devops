# VPC Variables
variable "vpc_cidr" {
  type        = string
  description = "CIDR for the VPC"
  default     = "10.0.0.0/16"
}

# Subnet Variables
variable "public_subnet_cidr1" {
  type        = string
  description = "CIDR for public subnet 1"
  default     = "10.0.101.0/24"
}

variable "public_subnet_cidr2" {
  type        = string
  description = "CIDR for public subnet 2"
  default     = "10.0.1.102/24"
}

variable "private_subnet_cidr" {
  type        = string
  description = "CIDR for the private subnet"
  default     = "10.0.1.0/24"
}