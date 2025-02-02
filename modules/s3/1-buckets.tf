resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  tags = {
    Name = var.bucket_name
    Project = "Frameshot"
  }
}

resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = true   # Bloqueia ACLs públicas (recomendado)
  block_public_policy     = false  # Permite políticas públicas (necessário!)
  ignore_public_acls      = true   # Ignora ACLs públicas (recomendado)
  restrict_public_buckets = false  # Permite políticas públicas específicas
}

resource "aws_s3_bucket_policy" "public_policy" {
  bucket = aws_s3_bucket.bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadForSpecificFolder"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "arn:aws:s3:::${aws_s3_bucket.bucket.bucket}/output_zip/*"
      }
    ]
  })
}

resource "aws_s3_object" "videos_folder" {
  bucket = aws_s3_bucket.bucket.id
  key    = "videos_input/" 
  content_type = "application/x-directory"
}

resource "aws_s3_object" "output_zip_folder" {
  bucket = aws_s3_bucket.bucket.id
  key    = "output_zip/" 
  content_type = "application/x-directory"
}