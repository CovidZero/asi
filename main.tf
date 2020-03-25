module "registry" {
  source      = "./modules/registry"
  app_name    = var.app_name
  environment = var.environment
}

module "network" {
  source      = "./modules/network"
  environment = var.environment
  vpc_cidr    = var.vpc_cidr
  region      = var.region
  az_count    = var.az_count
}

module "fargate" {
  source            = "./modules/fargate"
  environment       = var.environment
  app_name          = var.app_name
  app_port          = var.app_port
  app_image         = "${module.registry.repository_uri}:latest"
  scale_min         = var.scale_min
  scale_max         = var.scale_max
  region            = var.region
  base_domain       = var.base_domain
  fargate_cpu       = var.fargate_cpu
  fargate_memory    = var.fargate_memory
  use_ssl           = var.use_ssl
  app_count         = var.app_count
  deploy_min_t      = var.deploy_min_t
  deploy_max_t      = var.deploy_max_t
  health_check_path = var.health_check_path
  vpc_id            = module.network.vpc_id
  vpc_cidr          = var.vpc_cidr
  public_subnet     = module.network.subnet_pub
  private_subnet    = module.network.subnet_prv
  db_name           = var.db_name
  db_username       = var.db_username
  db_passwd         = var.db_passwd
  jwt_secret_key    = var.jwt_secret_key
  auth_username     = var.auth_username
  auth_password     = var.password
}

module "buildndeploy" {
  source            = "./modules/buildndeploy"
  environment       = var.environment
  region            = var.region
  registry_uri      = module.registry.repository_uri
  repository_owner  = var.repository_owner
  repository_name   = var.repository_name
  repository_branch = var.repository_branch
  ecs_cluster_name  = module.fargate.cluster_name
  ecs_service_name  = module.fargate.service_name
  task_subnet_id    = module.network.subnet_prv
  task_secgrp_id    = module.fargate.task_secgrp_id
  github_token      = var.github_token
}
