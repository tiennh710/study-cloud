## study-cloud
# Cài đặt Terraform
sudo yum update -y

sudo yum install -y yum-utils unzip curl

sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo

sudo yum -y install terraform

terraform -version

# Cài đặt docker
sudo yum update -y

sudo amazon-linux-extras enable docker

sudo yum install -y docker

# Bắt đầu Docker daemon
sudo systemctl start docker

sudo systemctl enable docker

sudo systemctl status docker

# Start terraform
terraform init

terraform plan

terraform apply

terraform destroy
