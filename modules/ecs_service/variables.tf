variable "name" {
  description = "Name of the ECS service."
  type        = string
}

variable "cluster_arn" {
  description = "ARN of the ECS cluster."
  type        = string
}

variable "task_definition_arn" {
  description = "ARN of the ECS task definition."
  type        = string
}

variable "desired_count" {
  description = "Number of desired ECS tasks."
  type        = number
  default     = 2
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for ECS tasks."
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID assigned to ECS tasks."
  type        = string
}

variable "target_group_arn" {
  description = "ALB target group ARN."
  type        = string
}

variable "container_name" {
  description = "Container name registered with the ALB target group."
  type        = string
  default     = "app"
}

variable "container_port" {
  description = "Container port registered with the ALB target group."
  type        = number
  default     = 8080
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}