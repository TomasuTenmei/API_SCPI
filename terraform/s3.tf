resource "aws_s3_bucket" "react_app_bucket" {
  bucket = "api-scpi-react-app"

  tags = {
    Name        = "React App Bucket"
    Environment = "Production"
  }

  # Configuration du site web pour le bucket S3
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource "aws_s3_bucket_public_access_block" "react_app_public_access_block" {
  bucket = aws_s3_bucket.react_app_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Crée une politique de bucket pour rendre les objets publics
resource "aws_s3_bucket_policy" "react_app_bucket_policy" {
  bucket = aws_s3_bucket.react_app_bucket.id

  policy = data.aws_iam_policy_document.bucket_policy.json
}

# Utilise un document IAM pour définir la politique du bucket
data "aws_iam_policy_document" "bucket_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.react_app_bucket.arn}/*"]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

locals {
  mime_types = {
    "html" = "text/html",
    "css"  = "text/css",
    "js"   = "application/javascript",
    "png"  = "image/png",
    "jpg"  = "image/jpeg",
    "jpeg" = "image/jpeg",
    "gif"  = "image/gif",
    "svg"  = "image/svg+xml"
  }
}

resource "aws_s3_bucket_object" "react_app_files" {
  for_each = fileset("${path.module}/../frontend/build", "**")

  bucket = aws_s3_bucket.react_app_bucket.id
  key    = each.value
  source = "${path.module}/../frontend/build/${each.value}"

  content_type = lookup(local.mime_types, lower(element(split(".", each.value), length(split(".", each.value)) - 1)), "application/octet-stream")
}

resource "aws_s3_bucket_website_configuration" "react_app_website" {
  bucket = aws_s3_bucket.react_app_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html" # Vous pouvez définir une page d'erreur spécifique ou rediriger vers l'index
  }
}
