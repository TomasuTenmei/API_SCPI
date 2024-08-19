output "rds_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.my_mysql_instance.endpoint
}

output "rds_port" {
  description = "The port for the RDS instance"
  value       = aws_db_instance.my_mysql_instance.port
}

output "rds_username" {
  description = "The master username for the RDS instance"
  value       = aws_db_instance.my_mysql_instance.username
}

output "rds_db_name" {
  description = "The database name of the RDS instance"
  value       = aws_db_instance.my_mysql_instance.db_name
}
