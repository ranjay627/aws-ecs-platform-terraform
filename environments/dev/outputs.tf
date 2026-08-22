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