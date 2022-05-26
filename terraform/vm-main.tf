# Create EC2 Instance
resource "aws_instance" "linux-server" {
  count                       = var.instance_count
  ami                         = data.aws_ami.ubuntu-linux-1804.id
  instance_type               = var.linux_instance_type
  subnet_id                   = module.vpc.private_subnets[0]
  vpc_security_group_ids      = [aws_security_group.aws-linux-sg.id]
  associate_public_ip_address = var.linux_associate_public_ip_address
  source_dest_check           = false
  key_name                    = aws_key_pair.key_pair.key_name
  # user_data                   = file("candidate.sh")
  
  # provisioner "file" {
  #   source      = "app"
  #   destination = "/home/${var.instance_user}"
  #   connection {
  #   host     = coalesce(self.public_ip, self.private_ip)
  #   type     = "ssh"
  #   user     = var.instance_user
  #   private_key = file("${aws_key_pair.key_pair.key_name}.pem")
  # }
  # }

  # provisioner "remote-exec" {
  #   inline = [
  #     "chmod +x /home/${var.instance_user}/app/setupInstance.sh",
  #     "sudo /home/${var.instance_user}/app/setupInstance.sh",
  #   ]
  #   connection {
  #   host     = coalesce(self.public_ip, self.private_ip)
  #   type     = "ssh"
  #   user     = var.instance_user
  #   private_key = file("${aws_key_pair.key_pair.key_name}.pem")
  # }
  # }

  # provisioner "local-exec" {
  #   command = "ansible-playbook -i ${aws_instance.linux-server.public_ip}, --private-key ${file("${aws_key_pair.key_pair.key_name}.pem")} pythonapp.yaml"
  # }

  # root disk
  root_block_device {
    volume_size           = var.linux_root_volume_size
    volume_type           = var.linux_root_volume_type
    delete_on_termination = true
    encrypted             = true
  }

  # extra disk
  ebs_block_device {
    device_name           = "/dev/xvda"
    volume_size           = var.linux_data_volume_size
    volume_type           = var.linux_data_volume_type
    encrypted             = true
    delete_on_termination = true
  }
  
  tags = {
    Name        = "${lower(var.app_name)}-${var.app_environment}-linux-server-${count.index + 1}"
    Environment = var.app_environment
  }
}


# # Create bastian host
# resource "aws_instance" "bastian_host" {
#   ami                         = data.aws_ami.ubuntu-linux-1804.id
#   instance_type               = var.linux_instance_type
#   subnet_id                   = module.vpc.public_subnets[0]
#   vpc_security_group_ids      = [aws_security_group.aws-linux-sg.id]
#   source_dest_check           = false
#   key_name                    = aws_key_pair.key_pair.key_name
# }