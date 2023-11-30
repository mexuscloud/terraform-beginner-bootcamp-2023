output "bucket_name" {
  description = "Bucket name for our static web hosting"
  value = module.home_FIFA_hosting.bucket_name
}

output "s3_website_endpoint" {
  description = "s3 static website hosting endpoint"
  value = module.home_FIFA_hosting.website_endpoint
}

output "cloudfront_url" {
  description = "The CloudFront Distribution Domain Name"
  value = module.home_FIFA_hosting.domain_name
}