# EP04 Architecture

## Overview
This project uses a small event-driven AWS architecture to detect an application failure, analyse it with Amazon Bedrock and send the result to Slack.

The demo application is a Lambda function that reads `status.txt` from S3. While the Lambda execution role has `s3:GetObject`, the application succeeds. When that permission is removed, the application generates a real AWS `AccessDenied` error.

CloudWatch Logs captures the error and a subscription filter forwards matching `AWSHORTS_ERROR` entries to the AI Analyser Lambda. The analyzer sends the error to Amazon Bedrock, receives a structured incident analysis, publishes it to SNS and then forwards it to Slack through Amazon Q Developer in chat applications.

## Architecture Diagram
```text
┌──────────────────────────────┐
│ Demo Application Lambda      │
│ ai-incident-demo-app         │
└──────────────┬───────────────┘
               │
               │ reads status.txt
               ▼
┌──────────────────────────────┐
│ Amazon S3                    │
└──────────────────────────────┘

If the application fails:

┌──────────────────────────────┐
│ Amazon CloudWatch Logs       │
└──────────────┬───────────────┘
               │
               │ filter:
               │ "AWSHORTS_ERROR"
               ▼
┌──────────────────────────────┐
│ AI Analyser Lambda           │
│ ai-incident-log-analyser     │
└──────────────┬───────────────┘
               │
               ▼
┌──────────────────────────────┐
│ Amazon Bedrock               │
│ Claude Haiku 4.5             │
└──────────────┬───────────────┘
               │
               │ returns:
               │ - root cause
               │ - probable fix
               │ - severity
               │ - explanation
               ▼
┌──────────────────────────────┐
│ Amazon SNS                   │
└──────────────┬───────────────┘
               │
               ▼
┌──────────────────────────────┐
│ Amazon Q Developer           │
│ in chat applications         │
└──────────────┬───────────────┘
               │
               ▼
┌──────────────────────────────┐
│ Slack                        │
└──────────────────────────────┘