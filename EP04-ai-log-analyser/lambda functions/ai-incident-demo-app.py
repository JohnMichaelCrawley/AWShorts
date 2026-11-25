import json
import os
import boto3

s3 = boto3.client("s3")

def lambda_handler(event, context):
    print("INFO: AWShorts demo application starting...")

    try:
        bucket = os.environ["bucket"]
        object_key = os.environ["object"]    
    
        print(f"INFO: Reading s3://{bucket}/{object_key}")

        response = s3.get_object(Bucket=bucket, Key=object_key)
        context = (
            response["Body"]
            .read()
            .decode("utf-8")
            .strip()
        )

        print(f"APP_HEALTHY: {context}")

        return {
            "statusCode": 200,
            "body": json.dumps({
                "status": "healthy",
                "message": context
            })
        }

    except Exception as error:
        print(
            f"AWSHORTS_ERROR: "
            f"{type(error).__name__}: {error}"
        )
        raise error



