# -- infra/aws/tf/variables.tf
# ============================================================================
# Variables
# ============================================================================

# variable "s3_config" {
#   description = "S3 bucket configuration passed from root module."
#   type = object({
#     bucket_name   = string
#     versioning    = bool
#     kms_key_alias = string
#     sse_algorithm = string
#     bucket_policy = string
#     bucket_keys   = list(string)
#   })
# }
variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}
variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "devl"

  validation {
    condition     = contains(["devl", "test", "prod"], var.environment)
    error_message = "Environment must be devl, test, or prod."
  }
}
variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "subhamay"

  validation {
    condition     = length(var.project_name) <= 30
    error_message = "Project name must be 30 characters or less to ensure S3 bucket name stays under 63 characters."
  }
}

variable "s3_config_path" {
  description = "Path to the S3 configuration JSON file"
  type        = string
  default     = "config.json"
}