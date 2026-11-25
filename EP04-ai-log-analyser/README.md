# EP04 AI Log Analyser (CloudWatch, Lambda, Bedrock, SNS, Slack)

## Overview
For this episode, I wanted to build a small AI-powered incident analysis workflow using AWS. The application starts in a healthy state by reading a file from S3. When I deliberately remove the Lambda function's S3 permission, the application fails and writes an error to CloudWatch Logs.

A CloudWatch subscription filter detects the error and forwards it to a second Lambda function. That Lambda sends the error to Amazon Bedrock using Claude Haiku 4.5, which analyses the incident and returns the likely root cause, severity, explanation and probable fix. The result is then published to Amazon SNS and forwarded to Slack through Amazon Q Developer in chat applications.

## Demo Flow
The episode demonstrates the full incident lifecycle:

- run the application while healthy
- confirm the Lambda can read `status.txt` from S3
- remove `s3:GetObject` permission
- trigger a real `AccessDenied` error
- capture the error in CloudWatch Logs
- send the matching log to the AI Analyzer Lambda
- analyse the error with Amazon Bedrock
- publish the AI incident report to SNS
- forward the incident notification to Slack
- restore the IAM permission
- confirm the application is healthy again

## Architecture
```text
Demo App Lambda → S3
       ↓
CloudWatch Logs
       ↓
Subscription Filter
       ↓
AI Analyzer Lambda
       ↓
Amazon Bedrock
       ↓
Amazon SNS
       ↓
Amazon Q Developer
       ↓
Slack