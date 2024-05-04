import json
import boto3


s3_client = boto3.client('s3')

def lambda_handler(event, context):
    try:
        
        event_data = event['data']

        
        processed_data = process_data(event_data)

       
        save_data_to_s3(processed_data)

       
        response = {
            'statusCode': 200,
            'body': json.dumps({'message': 'Lambda function executed successfully'}),
            'processed_data': processed_data
        }
    except Exception as e:
        
        response = {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }

    return response

def process_data(data):
    
    processed_data = data.upper() 
    return processed_data

def save_data_to_s3(data):
    bucket_name = 'data-processing-task-1-bucket'  
    user_id = '992382699930'  
    object_key = f'user_profiles/{user_id}/file.csv'  
    s3_client.put_object(Bucket=bucket_name, Key=object_key, Body=data.encode('utf-8'))
