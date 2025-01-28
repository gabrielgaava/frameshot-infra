resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  tags = {
    Name = var.bucket_name
    Project = "Frameshot"
  }
}

resource "aws_s3_object" "videos_folder" {
  bucket = aws_s3_bucket.bucket.bucket
  key    = "videos_input/" 
  acl    = "private"
}

resource "aws_s3_object" "folder2" {
  bucket = aws_s3_bucket.bucket.bucket
  key    = "output_zip/" 
  acl    = "private"
}

