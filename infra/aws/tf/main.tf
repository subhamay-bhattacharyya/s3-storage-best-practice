# -- infra/aws/tf/main.tf
# ============================================================================
# Main Configuration
# ============================================================================

# 1. S3 Bucket following 
module "s3" {
  source = "github.com/subhamay-bhattacharyya-tf/terraform-aws-s3-bucket/modules/bucket?ref=main"

  s3_config = local.s3_config
}