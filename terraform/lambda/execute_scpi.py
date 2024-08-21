import json
import boto3
from botocore.exceptions import ClientError

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('Oscilloscopes')

def handler(event, context):
    try:
        # Extraire les données de la requête
        body = json.loads(event['body'])
        oscilloscope_id = body.get('oscilloscope_id')
        command = body.get('command')

        if not oscilloscope_id or not command:
            return {
                'statusCode': 400,
                'body': json.dumps('oscilloscope_id et command sont requis')
            }

        # Récupérer les détails de l'oscilloscope à partir de DynamoDB
        response = table.get_item(Key={'oscilloscope_id': oscilloscope_id})

        if 'Item' not in response:
            return {
                'statusCode': 404,
                'body': json.dumps('Oscilloscope non trouvé')
            }

        oscilloscope = response['Item']

        # Simuler l'exécution de la commande SCPI (à personnaliser)
        result = execute_scpi_command(oscilloscope, command)

        return {
            'statusCode': 200,
            'body': json.dumps(result)
        }

    except ClientError as e:
        return {
            'statusCode': 500,
            'body': json.dumps(f"Erreur interne du serveur: {e}")
        }

def execute_scpi_command(oscilloscope, command):
    # Cette fonction doit être implémentée pour exécuter la commande SCPI sur l'oscilloscope réel
    # Actuellement, elle simule simplement une réponse.
    return {
        "status": "success",
        "command": command,
        "response": "Simulated response from oscilloscope"
    }
