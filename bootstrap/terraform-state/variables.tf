variable "aws_region" {
  description = "AWS region where the Terraform state infrastructure will be created."
  type        = string
  default     = "ap-south-1"
}

variable "state_bucket_name" {
  description = "Globally unique S3 bucket name for Terraform state."
  type        = string
}