# Tạo key pair mới với tên động
resource "aws_key_pair" "dynamic_key" {
  key_name   = "${var.project_name}-${var.key_pair_name}-${formatdate("YYYYMMDD-hhmmss", timestamp())}"
  public_key = file("~/.ssh/ec2-free-tier-key.pub")
}

# Tạo security group với tên động
resource "aws_security_group" "dynamic_sg" {
  name        = "${var.project_name}-${var.environment}-sg"
  description = "Security Group for ${var.project_name} (${var.environment})"

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-sg"
    Environment = var.environment
    Project     = var.project_name
  }
}

# Tạo EC2 instance với tên động
resource "aws_instance" "dynamic_ec2" {
  ami                    = data.aws_ami.amazon_linux_free_tier.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.dynamic_key.key_name
  vpc_security_group_ids = [aws_security_group.dynamic_sg.id]

  tags = {
    Name        = "${var.project_name}-${var.environment}-ec2"
    Environment = var.environment
    Project     = var.project_name
    CreatedAt   = formatdate("YYYY-MM-DD hh:mm:ss", timestamp())
  }
}
