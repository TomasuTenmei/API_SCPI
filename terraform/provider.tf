# provider.tf
provider "aws" {
  region = var.aws_region  # Utilisation d'une variable pour la région
}
