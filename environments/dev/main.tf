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

  name = "ecs-platform-dev"

  tags = {
    Environment = var.environment
  }
}

module "ecs" {
  source = "../../modules/ecs"

  cluster_name = "ecs-platform-dev"

  tags = {
    Environment = var.environment
  }
}