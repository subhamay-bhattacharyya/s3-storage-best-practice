# -- infra/aws/tf/locals.tf
# ============================================================================
# Local Values
# ============================================================================

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

# Compute KMS key alias first (no dependency on s3_config)
locals {
  kms_key_alias_raw = try(jsondecode(file("${path.module}/${var.s3_config_path}")).aws.s3.kms_key_alias, null)
  kms_key_alias     = local.kms_key_alias_raw != null ? (startswith(local.kms_key_alias_raw, "alias/") ? local.kms_key_alias_raw : "alias/${local.kms_key_alias_raw}") : null
}

data "aws_kms_key" "kms" {
  count  = local.kms_key_alias != null ? 1 : 0
  key_id = local.kms_key_alias
}

locals {

  tags = {
    Environment = var.environment
    Project     = var.project_name
    CreatedBy   = "Terraform"
    ManagedBy   = "Terraform"
    Owner       = "DevOps"
    CostCenter  = var.project_name
  }
  current_region = data.aws_region.current.id

  # Parse config from JSON files (relative to module path)
  s3_config_file = jsondecode(file("${path.module}/${var.s3_config_path}"))

  # S3 Configuration
  s3_config = {
    bucket_name   = "${var.project_name}-${local.s3_config_file.s3.bucket_name}-${var.environment}-${var.aws_region}"
    versioning    = local.s3_config_file.s3.versioning == true ? true : false
    kms_key_alias = local.kms_key_alias != null ? replace(local.kms_key_alias, "alias/", "") : null
    sse_algorithm = local.kms_key_alias != null ? "aws:kms" : null
    bucket_keys   = try(local.s3_config_file.s3.bucket_keys, null)
    bucket_policy = templatefile("${path.module}/templates/bucket-policy/s3-bucket-policy.tftpl", {
      aws_account_id = data.aws_caller_identity.current.account_id
      bucket_name    = "${var.project_name}-${local.s3_config_file.s3.bucket_name}-${var.environment}-${var.aws_region}"
    })
  }
}
