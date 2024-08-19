resource "aws_s3_bucket" "static_assets" {
  bucket = "${var.environment}-static-assets-bucket"

  tags = {
    Name        = "${var.environment}-static-assets"
    Environment = var.environment
  }
}

# Définir une politique de bucket pour rendre le contenu public
resource "aws_s3_bucket_policy" "static_assets_policy" {
  bucket = aws_s3_bucket.static_assets.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = "*"
        Action = "s3:GetObject"
        Resource = "${aws_s3_bucket.static_assets.arn}/*"
      }
    ]
  })
}
