#!/usr/bin/env bash
set -e

source colours.sh

# Destroy terraform infrastructure
echo -e "${GREEN}==============================${NC}"
echo -e "${GREEN}Destroying Terraform Infra${NC}"
echo -e "${GREEN}==============================${NC}"

cd terraform
terraform destroy -auto-approve

# Complete
echo -e "${GREEN}==============================${NC}"
echo -e "${GREEN}Terraform removed successfully${NC}"
echo -e "${GREEN}==============================${NC}"