import json
import boto3
from botocore.exceptions import ClientError

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('Oscilloscopes')

def handler(event, context):
    try:
        # Récupérer la liste de tous les oscilloscopes
        response = table.scan()

        return {
            'statusCode': 200,
            'body': json.dumps(response['Items'])
        }

    except ClientError as e:
        return {
            'statusCode': 500,
            'body': json.dumps(f"Erreur interne du serveur: {e}")
        }
