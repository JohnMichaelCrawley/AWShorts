# EP01-Deploy-To-ECS-Fargate-Flask-App

## Overview 

In this episode I used CI/CD with GitHub Actions to push a basic Flask application to ECR and ECS (Fargate) which will also display logs on CloudWatch logs. 
I also wanted to keep in the errors I made and showed how I fixed them 

## Stack  

AWS
* ECR 
* ECS
* CloudWatch 

Containerisation:
* Docker

Application:
* Flask with Python 3.11

## Steps I took for this project

1. Install virtual environment and activate
2. Install Flask 
3. Make the Flask application
4. Setup the Dockerfile and requirements.txt
5. Create ECR repository
6. Create ECS task definition
7. Create ECS cluster 
8. Create ECS service
9. Download the task definition and shorten it
10. Created GitHub Actions secrets for AWS access and secret key
11. Create the workflow for GitHub Actions
12. Push to main branch creating the deployment 
13. Configure the security group for inbound to allow TCP with port range 5000 for the Flask application
