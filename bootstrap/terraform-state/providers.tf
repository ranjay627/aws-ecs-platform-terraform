provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project   = "aws-ecs-platform"
      ManagedBy = "Terraform"
      Purpose   = "terraform-state"
    }
  }
}