# -- infra/aws/tf/outputs.tf
# ============================================================================
# Outputs
# ============================================================================

############ S3 Bucket Outputs ############################
output "s3_bucket_name" {
  description = "S3 bucket name used for static website"
  value       = module.s3.bucket_id
}
output "s3_bucket_region" {
  description = "S3 bucket region"
  value       = module.s3.bucket_region
}
output "s3_bucket_arn" {
  description = "S3 bucket ARN"
  value       = module.s3.bucket_arn
}
output "s3_versioning_status" {
  description = "S3 bucket versioning status"
  value       = module.s3.versioning_status
}
