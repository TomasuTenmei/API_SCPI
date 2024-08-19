# Créer un rôle IAM pour la fonction Lambda
resource "aws_iam_role" "lambda_role" {
  name = "lambda_rds_access_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Sid    = "",
        Principal = {
          Service = "lambda.amazonaws.com",
        },
      },
    ],
  })

  inline_policy {
    name = "rds-access-policy"
    policy = jsonencode({
      Version = "2012-10-17",
      Statement = [
        {
          Effect = "Allow",
          Action = [
            "rds:*",
            "logs:*",
            "cloudwatch:*",
          ],
          Resource = "*",
        },
      ],
    })
  }
}

# Créer la fonction Lambda
resource "aws_lambda_function" "insert_data_lambda" {
  filename         = "${path.module}/lambda/add_data_to_db.zip"
  function_name    = "insert_data_lambda"
  role             = aws_iam_role.lambda_role.arn
  handler          = "add_data_to_db.lambda_handler"
  runtime          = "python3.9"

  environment {
    variables = {
      RDS_HOST     = aws_db_instance.my_mysql_instance.endpoint
      RDS_USER     = var.db_username
      RDS_PASSWORD = var.db_password
      RDS_DB       = "mydatabase"
    }
  }

  source_code_hash = filebase64sha256("${path.module}/lambda/add_data_to_db.zip")
}
