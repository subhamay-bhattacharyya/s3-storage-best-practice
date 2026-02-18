# S3 Storage Best Practice

![Release](https://github.com/subhamay-bhattacharyya/s3-storage-best-practice/actions/workflows/ci.yaml/badge.svg)&nbsp;![AWS](https://img.shields.io/badge/AWS-FF9900?&logo=amazon-aws&logoColor=white)&nbsp;![Terraform](https://img.shields.io/badge/Terraform-7B42BC?&logo=terraform&logoColor=white)&nbsp;![Commit Activity](https://img.shields.io/github/commit-activity/t/subhamay-bhattacharyya/s3-storage-best-practice)&nbsp;![Last Commit](https://img.shields.io/github/last-commit/subhamay-bhattacharyya/s3-storage-best-practice)

## Overview

A Terraform module for provisioning AWS S3 buckets following security and operational best practices. This repository provides a reusable, configurable infrastructure-as-code solution for S3 bucket deployment.

## Features

- JSON-based configuration for S3 bucket settings
- KMS encryption support
- Versioning enabled by default
- Customizable bucket policies via templates
- Standardized resource tagging
- Unit tests using Terraform test framework

## Project Structure

```
infra/aws/tf/
├── main.tf              # S3 module instantiation
├── variables.tf         # Input variables with validation
├── locals.tf            # Local values and configuration parsing
├── outputs.tf           # Module outputs
├── providers.tf         # Provider configuration
├── backends.tf          # State backend configuration
├── config.json          # S3 bucket configuration
├── terraform.tfvars     # Variable values
├── templates/
│   └── bucket-policy/
│       └── s3-bucket-policy.tftpl
└── tests/
    └── unit.tftest.hcl  # Unit tests
```

## Configuration

Edit `config.json` to customize your S3 bucket:

```json
{
    "s3": {
        "bucket_name": "aws-s3-best-practice",
        "versioning": true,
        "kms_key_alias": "SB-KMS"
    }
}
```

## Usage

```bash
cd infra/aws/tf

# Initialize
terraform init -backend-config="bucket=your-state-bucket" \
               -backend-config="key=terraform.tfstate" \
               -backend-config="region=us-east-1"

# Plan
terraform plan

# Apply
terraform apply

# Run tests
terraform test
```

## Variables

| Name | Description | Default |
|------|-------------|---------|
| `project_name` | Project name for resource naming (max 30 chars) | `subhamay` |
| `environment` | Environment name (devl, test, prod) | `devl` |
| `aws_region` | AWS region for resources | `us-east-1` |
| `s3_config_path` | Path to S3 configuration JSON file | `config.json` |

## Outputs

| Name | Description |
|------|-------------|
| `s3_bucket_id` | The name of the S3 bucket |
| `s3_bucket_arn` | The ARN of the S3 bucket |
| `s3_bucket_region` | The AWS region of the S3 bucket |
| `s3_bucket_domain_name` | The domain name of the S3 bucket |
| `s3_bucket_tags` | The tags of the S3 bucket |

## Testing

Unit tests validate:
- Bucket name format and length (3-63 characters)
- Versioning configuration
- ARN format
- Encryption settings
- Bucket policy existence
- Required tags

Run tests:
```bash
terraform test
```

## License

MIT License - See [LICENSE](LICENSE) for details.
