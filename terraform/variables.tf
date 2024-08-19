variable "aws_region" {
  description = "La région AWS où les ressources seront déployées"
  type        = string
  default     = "eu-west-3" # Paris
}

variable "environment" {
  description = "Environnement de déploiement (dev, staging, prod)"
  type        = string
  default     = "dev"
}
