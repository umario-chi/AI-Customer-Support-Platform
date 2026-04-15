# Prerequisites: Create these resources before running terraform init:
#   1. S3 bucket with versioning and encryption enabled
#   2. DynamoDB table with partition key "LockID" (String)

terraform {
  backend "s3" {
    bucket         = "ai-platform-terraform-state"
    key            = "ai-platform/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "ai-platform-terraform-lock"
  }
}
