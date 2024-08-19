import pymysql
import os

def lambda_handler(event, context):
    # Connexion à la base de données
    connection = pymysql.connect(
        host=os.environ['RDS_HOST'],
        user=os.environ['RDS_USER'],
        password=os.environ['RDS_PASSWORD'],
        database=os.environ['RDS_DB']
    )
    
    try:
        with connection.cursor() as cursor:
            # Exemple de requête SQL pour insérer des données
            sql = "INSERT INTO users (name, email) VALUES (%s, %s)"
            cursor.execute(sql, ('Alice', 'alice@example.com'))
            cursor.execute(sql, ('Bob', 'bob@example.com'))
        
        # Committer la transaction
        connection.commit()
        
    finally:
        connection.close()
        
    return {
        'statusCode': 200,
        'body': 'Data inserted successfully'
    }
