variable "log_group_name" {
  description = "Name of the CloudWatch log group."
  type        = string
}

variable "retention_in_days" {
  description = "Number of days to retain application logs."
  type        = number
  default     = 30

  validation {
    condition     = var.retention_in_days > 0
    error_message = "retention_in_days must be greater than zero."
  }
}

variable "tags" {
  description = "Common tags applied to CloudWatch resources."
  type        = map(string)
  default     = {}
}