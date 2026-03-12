#!/usr/bin/env bash
set -e
# get colour formatting 
source colours.sh
# Update package list
echo -e "${GREEN}==============================${NC}"
echo -e "${GREEN}Updating package lists${NC}"
echo -e "${GREEN}==============================${NC}"
sudo apt update
# Install Terraform
echo -e "${GREEN}==============================${NC}"
echo -e "${GREEN}Installing Terraform${NC}"
echo -e "${GREEN}==============================${NC}"
echo "Updating package list and installing dependencies..."
sudo apt-get update -y
sudo apt-get install -y gnupg software-properties-common wget

echo "Adding HashiCorp GPG key..."
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
sudo apt update
echo "Verifying GPG key fingerprint..."
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint

echo "Adding HashiCorp repository..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com noble main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
echo "Updating apt with new repository..."
echo "Installing Terraform..."
sudo apt-get install -y terraform
echo "Terraform installed successfully!"
terraform -version
# Install Ansible
echo -e "${GREEN}==============================${NC}"
echo -e "${GREEN}Installing Ansible${NC}"
echo -e "${GREEN}==============================${NC}"
sudo apt install -y ansible
# Install AWS CLI
echo -e "${GREEN}==============================${NC}"
echo -e "${GREEN}Installing AWS CLI${NC}"
echo -e "${GREEN}==============================${NC}"
sudo apt install -y awscli
# Install Python Libs
echo -e "${GREEN}==============================${NC}"
echo -e "${GREEN}Installing Python Libs ${NC}"
echo -e "${GREEN}==============================${NC}"
sudo apt install -y python3
sudo apt install -y python3-pip
python3 -m pip install --break-system-packages boto boto3 botocore
# End prompt 
echo -e "${GREEN}==============================${NC}"
echo -e "${GREEN}All tools installed successfully${NC}"
echo -e "${GREEN}==============================${NC}"