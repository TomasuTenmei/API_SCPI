import json
import boto3
from botocore.exceptions import ClientError
import uuid

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('Oscilloscopes')

def handler(event, context):
    try:
        # Extraire les données de la requête
        body = json.loads(event['body'])
        model = body.get('model')
        ip_address = body.get('ip_address')

        if not model or not ip_address:
            return {
                'statusCode': 400,
                'body': json.dumps('model et ip_address sont requis')
            }

        # Ajouter un nouvel oscilloscope dans DynamoDB
        oscilloscope_id = str(uuid.uuid4())
        item = {
            'oscilloscope_id': oscilloscope_id,
            'model': model,
            'ip_address': ip_address
        }
        table.put_item(Item=item)

        return {
            'statusCode': 201,
            'body': json.dumps({'oscilloscope_id': oscilloscope_id})
        }

    except ClientError as e:
        return {
            'statusCode': 500,
            'body': json.dumps(f"Erreur interne du serveur: {e}")
        }
