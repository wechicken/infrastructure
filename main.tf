terraform {
  required_version = "~>1.0"
}

provider "aws" {
  region    = "ap-northeast-2"
  profile   = "wechicken"
}

module "iam" {
  source = "./iam"
}

module "vpc" {
  source = "./vpc"
}

module "security-groups" {
  source = "./security-groups"

  dmz = module.vpc.dmz
}

module "wechicken-ecr" {
  source = "./ecr"

  repository-name = "wechicken"
}

module "wechicken-ecs" {
  source = "./ecs"

  cluster-name = "wechicken"
}

module "wechicken-development" {
  source = "./wechicken/development"

  name = "wechicken"
  security-groups-allow-web = module.security-groups.allow-web
  vpc-dmz = module.vpc.dmz
  dmz-public-2a = module.vpc.dmz-public-2a
  dmz-public-2c = module.vpc.dmz-public-2c
  repository = module.wechicken-ecr.repository
  cluster = module.wechicken-ecs.cluster
  iam-role-ecs = module.iam.ecs
  desired-capacity = 1
}

module "wechicken-production" {
  source = "./wechicken/production"

  name = "wechicken"
  security-groups-allow-web = module.security-groups.allow-web
  vpc-dmz = module.vpc.dmz
  dmz-public-2a = module.vpc.dmz-public-2a
  dmz-public-2c = module.vpc.dmz-public-2c
  repository = module.wechicken-ecr.repository
  cluster = module.wechicken-ecs.cluster
  iam-role-ecs = module.iam.ecs
  desired-capacity = 1
}
