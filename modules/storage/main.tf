####################################################
# Create S3 Bucket
####################################################
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name 
}

# Disable Block Public Access Settings
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.my_bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

####################################################
# Create Bucket Policy
####################################################
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.my_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Sid     = "PublicRead"
        Principal = "*"
        #Principal = { AWS = "arn:aws:iam::123456789012:user/my-user" }  # Change to your IAM user
        Action    = ["s3:GetObject"]
        Resource  = [
          "arn:aws:s3:::${aws_s3_bucket.my_bucket.id}",
          "arn:aws:s3:::${aws_s3_bucket.my_bucket.id}/*"
        ]
      }
    ]
  })
  
  # Ensure public access block is configured first
  depends_on = [aws_s3_bucket_public_access_block.public_access,
                aws_s3_bucket_cors_configuration.cors
  ]
}

####################################################
# Create Bucket CORS Policy
####################################################
resource "aws_s3_bucket_cors_configuration" "cors" {
  bucket = aws_s3_bucket.my_bucket.id

  cors_rule {
    allowed_methods = ["GET", "POST", "PUT", "DELETE", "HEAD"]
    allowed_origins = ["*"]  # Restrict to specific domains if needed
    allowed_headers = ["*"]
    expose_headers  = ["ETag", "Access-Control-Allow-Origin", "x-amz-server-side-encryption", "x-amz-request-id", "x-amz-id-2"]
    max_age_seconds = 3000
  }
}

####################################################
# Customize bucket ownership
####################################################

resource "aws_s3_bucket_ownership_controls" "bucket_ownership" {
  bucket = aws_s3_bucket.my_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}