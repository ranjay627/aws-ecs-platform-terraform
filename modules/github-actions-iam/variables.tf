variable "name" {
  description = "Name prefix for GitHub Actions IAM resources."
  type        = string
}

variable "github_repository" {
  description = "GitHub repository allowed to assume the deployment role."
  type        = string
}

variable "github_branch" {
  description = "GitHub branch allowed to assume the deployment role."
  type        = string
  default     = "main"
}

variable "ecr_repository_arn" {
  description = "ARN of the ECR repository GitHub Actions can push to."
  type        = string
}

variable "ecs_cluster_arn" {
  description = "ARN of the ECS cluster GitHub Actions can deploy to."
  type        = string
}

variable "ecs_service_arn" {
  description = "ARN of the ECS service GitHub Actions can update."
  type        = string
}

variable "tags" {
  description = "Common tags applied to GitHub Actions IAM resources."
  type        = map(string)
  default     = {}
}