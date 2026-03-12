# AWS Provider
provider "aws" {
    region = var.region
    profile = "default"
    shared_credentials_files = ["~/.aws/credentials"]
}

# Security Group
resource "aws_security_group" "web_sg"{
    name = "web_sg"
    description ="Allow SSH and Python web traffic"


    # SSH Access

    ingress {
        description = "SSH Access"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Python Web Server
    ingress {
        description = "Python Web Server"
        from_port = 8000
        to_port = 8000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Outbound Traffic 
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# SSH Key Pair
resource "aws_key_pair" "devops_key" {
    key_name = "devops-key"
    public_key = file(pathexpand("~/.ssh/id_rsa.pub"))
}

# EC2 Instances
resource "aws_instance" "servers" {
    count = var.instance_count
    ami           = "ami-03446a3af42c5e74e"
    instance_type = var.instance_type

    key_name = aws_key_pair.devops_key.key_name

    vpc_security_group_ids = [aws_security_group.web_sg.id] 

    tags = {
        Name    = var.instance_names[count.index]
        Project = "ep2"
        Role    = "web"
    }




}
