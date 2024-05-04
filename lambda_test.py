import boto3
import json

# Initialize AWS Lambda client
lambda_client = boto3.client('lambda')

# Sample event data for testing
sample_event = {
    'data': 'sample_data'
}

# Invoke the Lambda function programmatically
response = lambda_client.invoke(
    FunctionName='my-lambda-function', 
    InvocationType='RequestResponse', 
    Payload=json.dumps(sample_event)
)

# Read the response from the Lambda function
response_payload = response['Payload'].read().decode('utf-8')

