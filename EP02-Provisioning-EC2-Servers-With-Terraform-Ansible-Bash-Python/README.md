# EP02 Provisioning EC2 Servers With Terraform, Ansible, Bash & Python

## Overview

In this episode of AWShorts (AWS Shorts) I built a small automation pipeline that provisions infrastructure using Terraform, dynamically discovers servers with Ansible, and deploys a Python dashboard to each EC2 instance.

The deployment is orchestrated using a Bash script which:
- Uses Terraform to provision EC2 infrastructure
- Uses AWS tags to identify servers
- Uses Ansible Dynamic Inventory to automatically discover instances
- Deploys a Python monitoring dashboard to each server

## Stack
- AWS EC2
- Terraform
- Ansible
- Bash scripting
- Python 

## Architecture
```
Bash Script
        ↓
Terraform
(Create EC2 infrastructure)
        ↓
AWS EC2 Instances
(tagged Server 1, Server 2...)
        ↓
Ansible Dynamic Inventory
(discover servers via AWS tags)
        ↓
Ansible Playbook
(installs Python, htop, psutil)
        ↓
Python Monitoring Web Server
(systemd service)
        ↓
Live Server Dashboard
```

## Usage
1. Ensure AWS configure CLI is configured
2. Generate 'ssh-keygen -t rsa -b 4096' if you don't have one
3. Run the 'install_tools.sh' script to install all the required tools for this project
4. Deploy ! - run 'deploy.sh' to deploy the project
5. Destroy ! - run 'destroy.sh' to terminate the Terraform infrastructure