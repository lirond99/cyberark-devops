# Application 
app_name        = "hello-cyberark" # Do NOT enter any spaces
app_environment = "dev"            # Dev, Test, Staging, Prod, etc

# AWS
aws_access_key  = ""
aws_secret_key  = ""
aws_region      = "us-east-1"

# Network
vpc_cidr            = "10.0.0.0/16"
public_subnet_cidr1 = "10.0.101.0/24"
public_subnet_cidr2 = "10.0.102.0/24"
private_subnet_cidr = "10.0.1.0/24"

# Linux VM
instance_count                    = 1
instance_user                     = "ubuntu"
linux_instance_type               = "t2.micro"
linux_associate_public_ip_address = true
linux_root_volume_size            = 20
linux_root_volume_type            = "gp2"
linux_data_volume_size            = 10
linux_data_volume_type            = "gp2"