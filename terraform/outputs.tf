output "api_url" {
  value = aws_api_gateway_deployment.scpi_api_deployment.invoke_url
  description = "Base URL for the API Gateway"
}
