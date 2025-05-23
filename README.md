## study-cloud
# Update yum and install some common package
sudo yum update -y  
sudo yum install -y yum-utils unzip curl  

# Install Terraform
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo  
sudo yum -y install terraform  
terraform -version  

# Install Docker
sudo amazon-linux-extras enable docker  
sudo yum install -y docker  
docket -version  

# Start Docker daemon
sudo systemctl start docker  
sudo systemctl enable docker  
sudo systemctl status docker  

# Docker's command
docker ps

# Terraform's command
terraform init
terrafor validate
terraform plan  
terraform apply
terraform apply -auto-approve
terraform destroy

------
# day1
terraform apply

# day2
terraform apply -var="environment=staging" -var="project_name=web-app"
