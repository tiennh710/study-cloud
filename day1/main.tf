provider "aws" {
  region = "ap-southeast-1"
}

# Lấy AMI miễn phí mới nhất của Amazon Linux 2
data "aws_ami" "amazon_linux_free_tier" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Tạo key pair mới từ file public key
resource "aws_key_pair" "free_tier_key" {
  key_name   = "free-tier-key-${formatdate("YYYYMMDD", timestamp())}"
  public_key = file("~/.ssh/ec2-free-tier-key.pub")
}

# Tạo security group chỉ cho phép SSH
resource "aws_security_group" "free_tier_sg" {
  name        = "free-tier-sg"
  description = "Allow SSH inbound traffic"

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Cảnh báo: Nên hạn chế IP trong môi trường production
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Free-Tier-Security-Group"
  }
}

# Tạo EC2 instance free tier
resource "aws_instance" "free_tier_ec2" {
  ami                    = data.aws_ami.amazon_linux_free_tier.id
  instance_type          = "t2.micro" # Loại instance free tier
  key_name               = aws_key_pair.free_tier_key.key_name
  vpc_security_group_ids = [aws_security_group.free_tier_sg.id]

  # Tối ưu cho free tier
  monitoring             = false
  disable_api_termination = false

  tags = {
    Name        = "Free-Tier-EC2"
    Environment = "Test"
    CostCenter  = "Free"
  }
}

# Output thông tin quan trọng
output "instance_info" {
  value = {
    public_ip  = aws_instance.free_tier_ec2.public_ip
    public_dns = aws_instance.free_tier_ec2.public_dns
    ssh_command = "ssh -i ~/.ssh/ec2-free-tier-key ec2-user@${aws_instance.free_tier_ec2.public_ip}"
  }
}
