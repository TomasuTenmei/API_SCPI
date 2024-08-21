resource "aws_dynamodb_table" "scpi_commands" {
  name         = "SCPICommands"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "command_id"

  attribute {
    name = "command_id"
    type = "S"
  }
}

resource "aws_dynamodb_table" "oscilloscopes" {
  name         = "Oscilloscopes"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "oscilloscope_id"

  attribute {
    name = "oscilloscope_id"
    type = "S"
  }
}
