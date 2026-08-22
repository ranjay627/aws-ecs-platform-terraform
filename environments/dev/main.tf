module "vpc" {
  source = "../../modules/vpc"

  name               = "ecs-platform-dev"
  vpc_cidr           = "10.0.0.0/16"
  availability_zones = ["ap-south-1a", "ap-south-1b"]

  public_subnet_cidrs = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  private_subnet_cidrs = [
    "10.0.11.0/24",
    "10.0.12.0/24"
  ]

  tags = {
    Environment = var.environment
  }
}


module "security_groups" {
  source = "../../modules/security-groups"

  name   = "ecs-platform-dev"
  vpc_id = module.vpc.vpc_id

  ecs_container_port = 8080
  rds_port           = 5432

  tags = {
    Environment = var.environment
  }
}

module "ecr" {
  source = "../../modules/ecr"

  repository_name = "ecs-platform-dev-app"

  tags = {
    Environment = var.environment
  }
}

module "iam" {
  source = "../../modules/iam"

  name                       = "ecs-platform-dev"
  rds_master_user_secret_arn = module.rds.master_user_secret_arn

  tags = {
    Environment = var.environment
  }
}

module "github_actions_iam" {
  source = "../../modules/github-actions-iam"

  name = "ecs-platform-dev"

  github_repository = "ranjay627/aws-ecs-platform-terraform"
  github_branch     = "main"

  ecr_repository_arn = module.ecr.repository_arn

  ecs_cluster_arn = module.ecs.cluster_arn
  ecs_service_arn = module.ecs_service.service_arn

  tags = {
    Environment = var.environment
  }
}

module "ecs" {
  source = "../../modules/ecs"

  cluster_name = "ecs-platform-dev"

  task_family    = "ecs-platform-dev-app"
  container_name = "app"

  container_image = "${module.ecr.repository_url}:1.0.0"

  container_port = 8080

  cpu    = 512
  memory = 1024

  task_execution_role_arn = module.iam.task_execution_role_arn
  task_role_arn           = module.iam.task_role_arn

  rds_master_user_secret_arn = module.rds.master_user_secret_arn

  environment_variables = {
    DB_HOST = module.rds.db_endpoint
    DB_PORT = tostring(module.rds.db_port)
    DB_NAME = module.rds.db_name
  }

  log_group_name = module.cloudwatch.log_group_name

  secrets = [
    {
      name       = "DB_USERNAME"
      value_from = "${module.rds.master_user_secret_arn}:username::"
    },
    {
      name       = "DB_PASSWORD"
      value_from = "${module.rds.master_user_secret_arn}:password::"
    }
  ]

  tags = {
    Environment = var.environment
  }
}

module "cloudwatch" {
  source = "../../modules/cloudwatch"

  log_group_name    = "/ecs/ecs-platform-dev"
  retention_in_days = 30

  tags = {
    Environment = var.environment
  }
}

module "alb" {
  source = "../../modules/alb"

  name              = "ecs-platform-${var.environment}-alb"
  target_group_name = "ecs-platform-${var.environment}-tg"

  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  security_group_id = module.security_groups.alb_security_group_id

  target_port = 8080

  environment = var.environment
}

module "ecs_service" {
  source = "../../modules/ecs_service"

  name                = "ecs-platform-${var.environment}-service"
  cluster_arn         = module.ecs.cluster_arn
  task_definition_arn = module.ecs.task_definition_arn

  desired_count = 2

  private_subnet_ids = module.vpc.private_subnet_ids
  security_group_id  = module.security_groups.ecs_security_group_id

  target_group_arn = module.alb.target_group_arn

  container_name = "app"
  container_port = 8080

  environment = var.environment
}

module "rds" {
  source = "../../modules/rds"

  name               = "ecs-platform-${var.environment}-rds"
  identifier         = "ecs-platform-${var.environment}-postgres"
  environment        = var.environment
  private_subnet_ids = module.vpc.private_subnet_ids
  security_group_id  = module.security_groups.rds_security_group_id

  engine_version        = "17"
  instance_class        = "db.t4g.micro"
  allocated_storage     = 50
  max_allocated_storage = 200

  database_name   = "appdb"
  master_username = "appadmin"

  backup_retention_period = 1
}