#!/usr/bin/env bash
set -e
# get colour formatting 
source colours.sh
# Update package list
echo -e "${GREEN}==============================${NC}"
echo -e "${GREEN}Initialising Terraform${NC}"
echo -e "${GREEN}==============================${NC}"
cd terraform 
terraform init
terraform plan 
terraform apply -auto-approve
sleep 120 
# Run Ansible
echo -e "${GREEN}==============================${NC}"
echo -e "${GREEN}Running Ansible${NC}"
echo -e "${GREEN}==============================${NC}"
cd ../ansible
ansible-playbook -i inventory playbook.yaml