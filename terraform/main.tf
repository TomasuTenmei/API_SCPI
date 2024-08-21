provider "aws" {
  region = var.region
}

resource "null_resource" "generate_frontend_env" {
  provisioner "local-exec" {
    command = "echo REACT_APP_API_URL=${aws_api_gateway_deployment.scpi_api_deployment.invoke_url} > ../frontend/.env"
  }

  depends_on = [aws_api_gateway_deployment.scpi_api_deployment]
}
