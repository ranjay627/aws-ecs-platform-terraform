resource "aws_db_subnet_group" "this" {
  name       = var.name
  subnet_ids = var.private_subnet_ids

  tags = {
    Name        = var.name
    Environment = var.environment
  }
}

resource "aws_db_instance" "this" {
  identifier = var.identifier

  engine         = "postgres"
  engine_version = var.engine_version

  instance_class        = var.instance_class
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = "gp3"
  storage_encrypted     = true

  db_name  = var.database_name
  username = var.master_username
  port     = 5432

  manage_master_user_password = true

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [var.security_group_id]

  publicly_accessible = false

  multi_az = true

  backup_retention_period = var.backup_retention_period
  backup_window            = var.backup_window
  maintenance_window      = var.maintenance_window

  auto_minor_version_upgrade = true
  apply_immediately          = false

  deletion_protection = true

  skip_final_snapshot       = false
  final_snapshot_identifier = "${var.identifier}-final"

  copy_tags_to_snapshot = true

  enabled_cloudwatch_logs_exports = [
    "postgresql",
  ]

  tags = {
    Name        = var.identifier
    Environment = var.environment
  }
}