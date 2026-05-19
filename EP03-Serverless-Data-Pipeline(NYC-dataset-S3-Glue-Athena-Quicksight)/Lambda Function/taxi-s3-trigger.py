import boto3

def lambda_handler(event, context):
    crawler = glue.get_crawler(Name='taxi-crawler')

    if crawler['Crawler']['State'] == 'READY':
        glue.start_crawler(Name='taxi-crawler')

    return {
        'statusCode': 200,
        'body': 'Crawler Checked!'
    }
