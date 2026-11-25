import base64
import gzip
import json
import os
import uuid

import boto3


bedrock = boto3.client("bedrock-runtime")
sns = boto3.client("sns")

MODEL_ID = os.environ["BEDROCK_MODEL_ID"]
SNS_TOPIC_ARN = os.environ["SNS_TOPIC_ARN"]


def lambda_handler(event, context):

    print("INFO: AI Analyser started")

    log_messages = get_log_messages(event)

    analysed = 0

    for message in log_messages:

        if "AWSHORTS_ERROR" not in message:
            continue

        error = message.split(
            "AWSHORTS_ERROR:",
            1
        )[-1].strip()

        print(f"INFO: Analysing error: {error}")

        analysis = analyse_error(error)

        send_to_slack(
            error,
            analysis
        )

        analysed += 1

    return {
        "statusCode": 200,
        "body": json.dumps({
            "analysed_count": analysed
        })
    }


def get_log_messages(event):

    # Manual Lambda test
    if "log" in event:
        return [event["log"]]

    # Real CloudWatch Logs event
    if "awslogs" in event:

        compressed = base64.b64decode(
            event["awslogs"]["data"]
        )

        uncompressed = gzip.decompress(
            compressed
        )

        payload = json.loads(
            uncompressed
        )

        return [
            item.get("message", "")
            for item in payload.get(
                "logEvents",
                []
            )
        ]

    return []


def analyse_error(error):

    prompt = f"""
You are an AWS Cloud Engineer and incident responder.

Analyse this AWS/application error.

Return ONLY valid JSON.

Use exactly these keys:

root_cause
probable_fix
severity
explanation

Severity must be exactly one of:

LOW
MEDIUM
HIGH
CRITICAL

Keep the answer concise and practical.

Error:

{error}
"""

    response = bedrock.converse(
        modelId=MODEL_ID,
        messages=[
            {
                "role": "user",
                "content": [
                    {
                        "text": prompt
                    }
                ]
            }
        ],
        inferenceConfig={
            "maxTokens": 500,
            "temperature": 0.2
        }
    )

    text = (
        response["output"]
        ["message"]
        ["content"][0]
        ["text"]
        .strip()
    )

    if text.startswith("```"):
        text = text.replace(
            "```json",
            ""
        )
        text = text.replace(
            "```",
            ""
        )
        text = text.strip()

    print(f"INFO: Bedrock response: {text}")

    return json.loads(text)


def send_to_slack(error, analysis):

    severity = analysis.get(
        "severity",
        "UNKNOWN"
    )

    cause = analysis.get(
        "root_cause",
        "Unknown"
    )

    fix = analysis.get(
        "probable_fix",
        "Unknown"
    )

    explanation = analysis.get(
        "explanation",
        "Unknown"
    )

    notification = {
        "version": "1.0",
        "source": "custom",
        "id": str(uuid.uuid4()),
        "content": {
            "textType": "client-markdown",
            "title": (
                f":rotating_light: "
                f"AI Incident - {severity}"
            ),
            "description": (
                f"*Severity:* {severity}\n\n"
                f"*Root Cause:*\n{cause}\n\n"
                f"*Explanation:*\n{explanation}\n\n"
                f"*Original Error:*\n`{error}`"
            ),
            "nextSteps": [
                fix
            ]
        }
    }

    print("INFO: Publishing incident to SNS")

    sns.publish(
        TopicArn=SNS_TOPIC_ARN,
        Message=json.dumps(notification)
    )

    print("INFO: Incident sent to SNS")
