variable "region" {
  default = "eu-west-3"
}

variable "aws_account_id" {
  description = "767397911402"
}

variable "s3_bucket_name" {
  type        = string
  description = "The name of the S3 bucket for hosting the React app"
}
