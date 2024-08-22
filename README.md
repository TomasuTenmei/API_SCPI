# Projet Cloud et ses services

Projet pour le cour "Le Cloud et ses services" de l'IPI Toulouse M1IL

## Sujet choisi du projet

API qui permet la recherche des commandes SCPI (Standard Commands for Programmable Instruments).

L'API est développé sous Python 3.11 avec FastAPI.

## Cahier des charges

### Contraintes

- L'application doit obligatoirement avoir un front (langage au choix).
- L'application doit être déployée avec Terraform obligatoirement (construction complète de lʼinfrastructure et des services associés).

### Services obligatoires

- API Gateway pour le développement dʼune API REST.
- Lambda pour lʼexécution des fonctions (pensez à regarder lesproblématiques liées aux CORS).
- Cognito pour pouvoir gérer la connexion des utilisateurs.
- S3 pour le stockage des images à afficher sur le site.
- RDS ou DynamoDB pour lʼhébergement des données (un schéma desdonnées sera à fournir).
- SNS / SQS pour la gestion des files dʼattentes et des mails.

## Méthode de l'API

- GET /commands
    - Params: model (requis), commandType (requis)
    - Réponse: 200 OK (commande SCPI), 404 Not Found, 400 Bad Request
    
- GET /models
    - Params: Aucun
    - Réponse: 200 OK (liste des modèles)

- GET /commands/types
    - Params: model (requis)
    - Réponse: 200 OK (types de commandes), 404 Not Found

- POST /commands
    - Body: model, commandType, scpiCommand (tous requis)
    - Réponse: 201 Created, 200 OK, 400 Bad Request

- DELETE /commands
    - Params: model (requis), commandType (requis)
    - Réponse: 200 OK, 404 Not Found

- GET /health
    - Params: Aucun
    - Réponse: 200 OK, 503 Service Unavailable

## TODO

- [x] API
- [x] Lambda
- [ ] Cognito
- [ ] S3
- [x] RDS ou DynamoDB
- [ ] SNS / SQS

# Liste des Commandes

    export AWS_ACCESS_KEY_ID=AKIA3FLD23NVHK4GTS75
    export AWS_SECRET_ACCESS_KEY=9F1j9c7zSVIFxoTJHat4kH/gReu8VeHMY4sDv9g3
    export AWS_DEFAULT_REGION=eu-west-3

    mariadb -h your-db-endpoint -P 3306 -u admin -p
