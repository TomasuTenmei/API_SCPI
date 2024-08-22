resource "aws_lambda_function" "execute_scpi" {
  function_name = "executeSCPI"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "execute_scpi.handler"
  runtime       = "python3.8"

  source_code_hash = filebase64sha256("lambda/execute_scpi.zip")
  filename         = "lambda/execute_scpi.zip"

  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.scpi_commands.name
    }
  }
}

resource "aws_lambda_function" "add_scpi_command" {
  function_name = "addSCPICommand"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "add_scpi_command.handler"
  runtime       = "python3.8"

  source_code_hash = filebase64sha256("lambda/add_scpi_command.zip")
  filename         = "lambda/add_scpi_command.zip"

  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.scpi_commands.name
    }
  }
}

resource "aws_lambda_function" "get_oscilloscopes" {
  function_name = "getOscilloscopes"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "get_oscilloscopes.handler"
  runtime       = "python3.8"

  source_code_hash = filebase64sha256("lambda/get_oscilloscopes.zip")
  filename         = "lambda/get_oscilloscopes.zip"
}

resource "aws_lambda_function" "add_oscilloscope" {
  function_name = "addOscilloscope"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "add_oscilloscope.handler"
  runtime       = "python3.8"

  source_code_hash = filebase64sha256("lambda/add_oscilloscope.zip")
  filename         = "lambda/add_oscilloscope.zip"

  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.oscilloscopes.name
    }
  }
}

resource "aws_lambda_permission" "api_gateway_invoke" {
  statement_id  = "apigateway-test-invoke-permissions"
  action        = "lambda:InvokeFunction"
  function_name = "addOscilloscope"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.scpi_api.execution_arn}/*/*"
}
