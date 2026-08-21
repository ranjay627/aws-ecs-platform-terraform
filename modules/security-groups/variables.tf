variable "name" {
  description = "Name prefix for security groups."
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where security groups will be created."
  type        = string
}

variable "alb_ingress_cidr_blocks" {
  description = "CIDR blocks allowed to access the ALB."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "ecs_container_port" {
  description = "Application port exposed by ECS tasks."
  type        = number
  default     = 8080
}

variable "rds_port" {
  description = "Database port used by RDS."
  type        = number
  default     = 5432
}

variable "tags" {
  description = "Common tags applied to security groups."
  type        = map(string)
  default     = {}
}