resource "aws_api_gateway_rest_api" "scpi_api" {
  name        = "SCPI API"
  description = "API for managing SCPI commands on oscilloscopes"
}

resource "aws_api_gateway_resource" "oscilloscopes" {
  rest_api_id = aws_api_gateway_rest_api.scpi_api.id
  parent_id   = aws_api_gateway_rest_api.scpi_api.root_resource_id
  path_part   = "oscilloscopes"
}

# POST method for adding an oscilloscope
resource "aws_api_gateway_method" "oscilloscopes_post" {
  rest_api_id   = aws_api_gateway_rest_api.scpi_api.id
  resource_id   = aws_api_gateway_resource.oscilloscopes.id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_integration" "oscilloscopes_post_integration" {
  rest_api_id             = aws_api_gateway_rest_api.scpi_api.id
  resource_id             = aws_api_gateway_resource.oscilloscopes.id
  http_method             = aws_api_gateway_method.oscilloscopes_post.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.add_oscilloscope.invoke_arn
}

resource "aws_api_gateway_method_response" "oscilloscopes_post_method_response" {
  rest_api_id = aws_api_gateway_rest_api.scpi_api.id
  resource_id = aws_api_gateway_resource.oscilloscopes.id
  http_method = aws_api_gateway_method.oscilloscopes_post.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "oscilloscopes_post_integration_response" {
  depends_on = [aws_api_gateway_integration.oscilloscopes_post_integration]

  rest_api_id = aws_api_gateway_rest_api.scpi_api.id
  resource_id = aws_api_gateway_resource.oscilloscopes.id
  http_method = aws_api_gateway_method.oscilloscopes_post.http_method
  status_code = aws_api_gateway_method_response.oscilloscopes_post_method_response.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
}

# OPTIONS method for handling CORS preflight requests
resource "aws_api_gateway_method" "oscilloscopes_options" {
  rest_api_id   = aws_api_gateway_rest_api.scpi_api.id
  resource_id   = aws_api_gateway_resource.oscilloscopes.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "oscilloscopes_options_integration" {
  rest_api_id             = aws_api_gateway_rest_api.scpi_api.id
  resource_id             = aws_api_gateway_resource.oscilloscopes.id
  http_method             = aws_api_gateway_method.oscilloscopes_options.http_method
  type                    = "MOCK"
  integration_http_method = "OPTIONS"
  
  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
}

resource "aws_api_gateway_method_response" "oscilloscopes_options_method_response" {
  rest_api_id = aws_api_gateway_rest_api.scpi_api.id
  resource_id = aws_api_gateway_resource.oscilloscopes.id
  http_method = aws_api_gateway_method.oscilloscopes_options.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Headers" = true
  }
}

resource "aws_api_gateway_integration_response" "oscilloscopes_options_integration_response" {
  depends_on = [aws_api_gateway_integration.oscilloscopes_options_integration]

  rest_api_id = aws_api_gateway_rest_api.scpi_api.id
  resource_id = aws_api_gateway_resource.oscilloscopes.id
  http_method = aws_api_gateway_method.oscilloscopes_options.http_method
  status_code = aws_api_gateway_method_response.oscilloscopes_options_method_response.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
    "method.response.header.Access-Control-Allow-Methods" = "'POST,GET,OPTIONS'"
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,Authorization'"
  }
}

# Deployment resource
resource "aws_api_gateway_deployment" "scpi_api_deployment" {
  depends_on = [
    aws_api_gateway_integration.oscilloscopes_post_integration,
    aws_api_gateway_integration.oscilloscopes_options_integration,
  ]

  rest_api_id = aws_api_gateway_rest_api.scpi_api.id
  stage_name  = "prod"
}
