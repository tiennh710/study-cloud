## study-cloud
# Update yum and install some common package
sudo yum update -y
sudo yum install -y yum-utils unzip curl

# Install Terraform
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform
terraform -version

# Cài đặt docker
sudo amazon-linux-extras enable docker
sudo yum install -y docker
docket -version

# Bắt đầu Docker daemon
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker

# Start terraform
terraform init
terraform plan
terraform apply
terraform destroy
