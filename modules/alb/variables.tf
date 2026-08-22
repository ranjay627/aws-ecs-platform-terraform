variable "name" {
  description = "Name of the Application Load Balancer."
  type        = string
}

variable "target_group_name" {
  description = "Name of the ALB target group."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the ALB target group is created."
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs for the Application Load Balancer."
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID for the Application Load Balancer."
  type        = string
}

variable "target_port" {
  description = "Port exposed by the application."
  type        = number
  default     = 8080
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}