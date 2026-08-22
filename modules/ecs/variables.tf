variable "cluster_name" {
  description = "Name of the ECS cluster."
  type        = string
}

variable "enable_container_insights" {
  description = "Enable ECS Container Insights."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Common tags applied to ECS resources."
  type        = map(string)
  default     = {}
}