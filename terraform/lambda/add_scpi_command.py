import json
import boto3
from botocore.exceptions import ClientError
import uuid

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('SCPICommands')

def handler(event, context):
    try:
        # Extraire les données de la requête
        body = json.loads(event['body'])
        name = body.get('name')
        syntax = body.get('syntax')
        description = body.get('description')

        if not name or not syntax:
            return {
                'statusCode': 400,
                'body': json.dumps('name et syntax sont requis')
            }

        # Ajouter une nouvelle commande SCPI dans DynamoDB
        command_id = str(uuid.uuid4())
        item = {
            'command_id': command_id,
            'name': name,
            'syntax': syntax,
            'description': description
        }
        table.put_item(Item=item)

        return {
            'statusCode': 201,
            'body': json.dumps({'command_id': command_id})
        }

    except ClientError as e:
        return {
            'statusCode': 500,
            'body': json.dumps(f"Erreur interne du serveur: {e}")
        }
