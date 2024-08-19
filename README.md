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

## TODO

- [ ] API
- [ ] Lambda
- [ ] Cognito
- [ ] S3
- [ ] RDS ou DynamoDB
- [ ] SNS / SQS
