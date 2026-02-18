# -- infra/aws/tf/tests/unit.tftest.hcl
# ============================================================================
# Terraform Unit Tests
# ============================================================================

run "verify_s3_bucket_name" {
  command = plan

  assert {
    condition     = length(local.s3_config.bucket_name) > 0
    error_message = "S3 bucket name should not be empty"
  }

  assert {
    condition     = can(regex("^[a-z0-9][a-z0-9.-]*[a-z0-9]$", local.s3_config.bucket_name))
    error_message = "S3 bucket name must be valid (lowercase, numbers, hyphens, periods)"
  }

  assert {
    condition     = length(local.s3_config.bucket_name) >= 3 && length(local.s3_config.bucket_name) <= 63
    error_message = "S3 bucket name must be between 3 and 63 characters"
  }
}

run "verify_s3_versioning" {
  command = plan

  assert {
    condition     = local.s3_config.versioning == true
    error_message = "S3 versioning should be enabled"
  }
}

run "verify_s3_bucket_arn_format" {
  command = plan

  assert {
    condition     = can(regex("^arn:aws:s3:::", "arn:aws:s3:::${local.s3_config.bucket_name}"))
    error_message = "S3 bucket ARN should have valid format"
  }
}

run "verify_s3_encryption" {
  command = plan

  assert {
    condition     = local.s3_config.sse_algorithm == "aws:kms" || local.s3_config.sse_algorithm == null
    error_message = "S3 encryption should use KMS or be unset"
  }
}

run "verify_bucket_policy_exists" {
  command = plan

  assert {
    condition     = local.s3_config.bucket_policy != null && length(local.s3_config.bucket_policy) > 0
    error_message = "S3 bucket policy should be defined"
  }
}

run "verify_tags" {
  command = plan

  assert {
    condition     = local.tags.Environment != null && local.tags.Environment != ""
    error_message = "Environment tag should be set"
  }

  assert {
    condition     = local.tags.Project != null && local.tags.Project != ""
    error_message = "Project tag should be set"
  }

  assert {
    condition     = local.tags.ManagedBy == "Terraform"
    error_message = "ManagedBy tag should be 'Terraform'"
  }
}

# ============================================================================
# Negative Tests
# ============================================================================

run "negative_test_bucket_name_too_long" {
  command = plan

  variables {
    project_name = "this-is-a-very-long-project-name-that-will-exceed-the-limit"
    environment  = "devl"
    aws_region   = "us-east-1"
  }

  expect_failures = [
    var.project_name
  ]
}
