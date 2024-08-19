# variables.tf
variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "eu-west-3"  # Paris
}

variable "db_username" {
  description = "The master username for the RDS instance"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "The master password for the RDS instance"
  type        = string
  default     = "Q5f7D8!r4d"
  sensitive   = true  # Indique que cette variable est sensible
}

variable "db_instance_class" {
  description = "The instance type for the RDS instance"
  type        = string
  default     = "db.t3.micro"  # Instance éligible au niveau gratuit
}