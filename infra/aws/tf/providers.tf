# -- infra/aws/tf/providers.tf
# ============================================================================
# Provider Configuration
# ============================================================================

terraform {
  required_version = ">= 1.11.0" # Adjust as needed for your environment

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 1.12.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.7.2"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
  default_tags {
    tags = local.tags
  }
}

provider "random" {
  # No specific configuration needed for random provider
}