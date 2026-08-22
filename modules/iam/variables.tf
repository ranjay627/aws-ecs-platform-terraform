variable "name" {
  description = "Name prefix for IAM resources."
  type        = string
}

variable "tags" {
  description = "Common tags applied to IAM resources."
  type        = map(string)
  default     = {}
}

variable "rds_master_user_secret_arn" {
  description = "ARN of the RDS-managed master user secret accessible by the ECS task."
  type        = string
}
