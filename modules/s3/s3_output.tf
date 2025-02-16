output "bucket_name" {
    description = "Expose S3 Bucket Name"
  value = aws_s3_bucket.my_bucket.id
}