output "vpc_id" {
  description = "ID of the VPC."
  value       = module.vpc.vpc_id
}

output "availability_zones" {
  description = "Availability zones used by the VPC."
  value       = module.vpc.availability_zones
}

output "public_subnet_ids" {
  description = "IDs of the public subnets."
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the private subnets."
  value       = module.vpc.private_subnet_ids
}

output "nat_gateway_ids" {
  description = "IDs of the NAT Gateways."
  value       = module.vpc.nat_gateway_ids
}


output "alb_security_group_id" {
  description = "Security group ID for the ALB."
  value       = module.security_groups.alb_security_group_id
}

output "ecs_security_group_id" {
  description = "Security group ID for ECS tasks."
  value       = module.security_groups.ecs_security_group_id
}

output "rds_security_group_id" {
  description = "Security group ID for RDS."
  value       = module.security_groups.rds_security_group_id
}

output "ecr_repository_name" {
  description = "ECR repository name."
  value       = module.ecr.repository_name
}

output "ecr_repository_url" {
  description = "ECR repository URL."
  value       = module.ecr.repository_url
}

output "task_execution_role_arn" {
  description = "ARN of the ECS task execution role."
  value       = module.iam.task_execution_role_arn
}

output "task_role_arn" {
  description = "ARN of the ECS task role."
  value       = module.iam.task_role_arn
}

output "ecs_cluster_id" {
  description = "ID of the ECS cluster."
  value       = module.ecs.cluster_id
}

output "ecs_cluster_arn" {
  description = "ARN of the ECS cluster."
  value       = module.ecs.cluster_arn
}

output "ecs_cluster_name" {
  description = "Name of the ECS cluster."
  value       = module.ecs.cluster_name
}

output "cloudwatch_log_group_name" {
  description = "Name of the ECS CloudWatch log group."
  value       = module.cloudwatch.log_group_name
}

output "cloudwatch_log_group_arn" {
  description = "ARN of the ECS CloudWatch log group."
  value       = module.cloudwatch.log_group_arn
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer."
  value       = module.alb.load_balancer_dns_name
}

output "alb_arn" {
  description = "ARN of the Application Load Balancer."
  value       = module.alb.load_balancer_arn
}

output "alb_target_group_arn" {
  description = "ARN of the ALB target group."
  value       = module.alb.target_group_arn
}

output "ecs_service_name" {
  description = "Name of the ECS service."
  value       = module.ecs_service.service_name
}

output "ecs_service_arn" {
  description = "ARN of the ECS service."
  value       = module.ecs_service.service_arn
}

output "rds_instance_id" {
  value = module.rds.db_instance_id
}

output "rds_endpoint" {
  value = module.rds.db_endpoint
}

output "rds_port" {
  value = module.rds.db_port
}

output "rds_database_name" {
  value = module.rds.db_name
}

output "rds_master_user_secret_arn" {
  value     = module.rds.master_user_secret_arn
  sensitive = true
}