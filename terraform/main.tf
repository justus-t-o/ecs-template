
module "vpc" {
  source = "./modules/vpc"
  name   = var.name
  cidr   = var.vpc_cidr
}

module "ecr" {
  source = "./modules/ecr"
  name   = var.name
}

module "ecs" {
  source             = "./modules/ecs"
  name               = var.name
  vpc_id             = module.vpc.vpc_id
  public_subnets     = module.vpc.public_subnets
  ecr_repository_url = module.ecr.repository_url
}
