module "iam" {
  source = "../../iam"
}

module "vpc" {
  source = "../../vpc"
}

module "security-groups" {
  source = "../../security-groups"

  dmz = module.vpc.dmz
}

module "ec2" {
  source = "../../ec2"

  security-group-allow-web = module.security-groups.allow-web
  vpc-dmz = module.vpc.dmz
  dmz-public-2a = module.vpc.dmz-public-2a
  dmz-public-2c = module.vpc.dmz-public-2c
}

module "ecr" {
  source = "../../ecr"
}

module "ecs" {
  source = "../../ecs"

  iam-role-ecs = module.iam.ecs
  wechicken-repository = module.ecr.wechicken-repository
  allow-web = module.security-groups.allow-web
  dmz-public-2a = module.vpc.dmz-public-2a
  dmz-public-2c = module.vpc.dmz-public-2c
  wechicken-dev-target-group = module.ec2.wechicken-dev-target-group
  wechicken-dev-listener = module.ec2.wechicken-dev-listener
}
