output "instance_details" {
  value = {
    instance_name = aws_instance.dynamic_ec2.tags.Name
    public_ip     = aws_instance.dynamic_ec2.public_ip
    security_group = aws_security_group.dynamic_sg.name
    key_pair      = aws_key_pair.dynamic_key.key_name
    ssh_command   = "ssh -i ~/.ssh/ec2-free-tier-key ec2-user@${aws_instance.dynamic_ec2.public_ip}"
  }
}
