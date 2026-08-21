terraform {
  backend "s3" {
    bucket       = "aws-ecs-platform-terraform-state"
    key          = "ecs-platform/dev/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}