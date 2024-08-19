# Crée un VPC
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "example-vpc"
  }
}

# Crée deux sous-réseaux dans ce VPC
resource "aws_subnet" "example" {
  count = 2
  vpc_id = aws_vpc.example.id

  cidr_block = element(["10.0.1.0/24", "10.0.2.0/24"], count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
}

# Crée un groupe de sécurité pour l'instance RDS dans ce même VPC
resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "Security group for RDS MySQL instance"
  vpc_id      = aws_vpc.example.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Ajustez selon vos besoins de sécurité
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Crée un groupe de sous-réseaux pour l'instance RDS
resource "aws_db_subnet_group" "default" {
  name       = "rds_subnet_group"
  subnet_ids = aws_subnet.example.*.id

  tags = {
    Name = "RDS subnet group"
  }
}

# Crée l'instance RDS MySQL
resource "aws_db_instance" "my_mysql_instance" {
  allocated_storage    = 20 # 20 Go de stockage (maximum pour le niveau gratuit)
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = var.db_instance_class
  identifier           = "my-mysql-instance"
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  publicly_accessible  = false

  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.default.name

  backup_retention_period = 7
  backup_window           = "03:00-04:00"
  maintenance_window      = "Mon:05:00-Mon:06:00"
}

# Données pour obtenir les zones de disponibilité disponibles
data "aws_availability_zones" "available" {}
