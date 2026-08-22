variable "name" {
  description = "RDS subnet group name."
  type        = string
}

variable "identifier" {
  description = "RDS instance identifier."
  type        = string
}

variable "environment" {
  description = "Environment name."
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs used by RDS."
  type        = list(string)
}

variable "security_group_id" {
  description = "RDS security group ID."
  type        = string
}

variable "engine_version" {
  description = "PostgreSQL engine version."
  type        = string
  default     = "17"
}

variable "instance_class" {
  description = "RDS instance class."
  type        = string
  default     = "db.t4g.medium"
}

variable "allocated_storage" {
  description = "Initial storage in GB."
  type        = number
  default     = 50
}

variable "max_allocated_storage" {
  description = "Maximum storage in GB."
  type        = number
  default     = 200
}

variable "database_name" {
  description = "Initial database name."
  type        = string
  default     = "appdb"
}

variable "master_username" {
  description = "Master database username."
  type        = string
  default     = "appadmin"
}

variable "backup_retention_period" {
  description = "Number of days to retain automated backups."
  type        = number
  default     = 7
}

variable "backup_window" {
  description = "Daily backup window in UTC."
  type        = string
  default     = "18:00-18:30"
}

variable "maintenance_window" {
  description = "Weekly maintenance window in UTC."
  type        = string
  default     = "sun:19:00-sun:20:00"
}