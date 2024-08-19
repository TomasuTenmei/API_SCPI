module "api_gateway" {
  source = "../../modules/api-gateway"
  # Autres variables spécifiques à l'environnement dev
}

module "lambda" {
  source = "../../modules/lambda"
  # Autres variables spécifiques à l'environnement dev
}
