resource "aws_cognito_user_pool" "main" {
  name = "scpi_user_pool"

  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }

  auto_verified_attributes = ["email"]
}

resource "aws_cognito_user_pool_client" "main" {
  user_pool_id = aws_cognito_user_pool.main.id
  name         = "my_app_client"
  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_CUSTOM_AUTH",
    "ALLOW_USER_SRP_AUTH",
  ]
  generate_secret = false
}

resource "aws_api_gateway_authorizer" "cognito_authorizer" {
  name                   = "cognito_authorizer"
  rest_api_id            = aws_api_gateway_rest_api.scpi_api.id
  identity_source        = "method.request.header.Authorization"
  authorizer_result_ttl_in_seconds = 300
  type                   = "COGNITO_USER_POOLS"
  provider_arns          = [aws_cognito_user_pool.main.arn]
}

resource "null_resource" "generate_aws_exports" {
  provisioner "local-exec" {
    command = <<EOT
mkdir -p ../frontend/src
cat > ../frontend/src/aws-exports.js <<EOF
const awsconfig = {
    Auth: {
        region: '${var.region}',
        userPoolId: '${aws_cognito_user_pool.main.id}',
        userPoolWebClientId: '${aws_cognito_user_pool_client.main.id}',
    }
};

export default awsconfig;
EOF
EOT
  }
  
  depends_on = [
    aws_cognito_user_pool.main,
    aws_cognito_user_pool_client.main,
  ]
}

resource "aws_cognito_identity_pool" "main" {
  identity_pool_name               = "main_identity_pool"
  allow_unauthenticated_identities = false

  cognito_identity_providers {
    client_id = aws_cognito_user_pool_client.main.id
    provider_name = aws_cognito_user_pool.main.endpoint
  }
}
