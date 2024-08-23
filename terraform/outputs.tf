output "api_url" {
  value = aws_api_gateway_deployment.scpi_api_deployment.invoke_url
  description = "Base URL for the API Gateway"
}

output "website_url" {
  value       = "http://${aws_s3_bucket.react_app_bucket.website_endpoint}"
  description = "The URL of the S3 bucket hosting the React application"
}

output "cognito_user_pool_id" {
  value = aws_cognito_user_pool.main.id
}

output "cognito_user_pool_client_id" {
  value = aws_cognito_user_pool_client.main.id
}

output "cognito_region" {
  value = var.region
}
