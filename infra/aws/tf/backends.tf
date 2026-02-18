# -- infra/aws/tf/backends.tf
# ============================================================================
# Backend Configuration
# ============================================================================
terraform {
  cloud {

    organization = "subhamay-bhattacharyya-projects"

    workspaces {
      name = "s3-storage-best-practice"
    }
  }
}