variable "cluster_name" {
  description = "Name of the ECS cluster."
  type        = string
}

variable "enable_container_insights" {
  description = "Enable ECS Container Insights."
  type        = bool
  default     = true
}

variable "task_family" {
  description = "ECS task definition family name."
  type        = string
}

variable "container_name" {
  description = "Name of the application container."
  type        = string
}

variable "container_image" {
  description = "Container image URI."
  type        = string
}

variable "container_port" {
  description = "Port exposed by the application container."
  type        = number
  default     = 8080
}

variable "cpu" {
  description = "Fargate task CPU units."
  type        = number
  default     = 512
}

variable "memory" {
  description = "Fargate task memory in MiB."
  type        = number
  default     = 1024
}

variable "task_execution_role_arn" {
  description = "IAM execution role ARN."
  type        = string
}

variable "task_role_arn" {
  description = "IAM task role ARN."
  type        = string
}

variable "log_group_name" {
  description = "CloudWatch log group name."
  type        = string
}

variable "tags" {
  description = "Common tags applied to ECS resources."
  type        = map(string)
  default     = {}
}