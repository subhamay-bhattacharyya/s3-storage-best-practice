# -- infra/aws/tf/data.tf
# ============================================================================
# Data Sources
# ============================================================================

# # AWS Region and Caller Identity
# data "aws_region" "current" {}

# data "aws_caller_identity" "current" {}

# # AWS Managed Prefix List
# data "aws_ec2_managed_prefix_list" "s3_vpce_prefix_list" {
#   name = "com.amazonaws.${data.aws_region.current.name}.s3"
# }