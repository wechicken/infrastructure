terraform {
  required_version = "~>1.0"
}

provider "aws" {
  region  = "ap-northeast-2"
  profile = "wechicken"
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

module "wechicken-mysql" {
  source = "./wechicken/database"

  security-groups-allow-mysql = module.security-groups.allow-mysql
  dmz-private-2a              = module.vpc.dmz-private-2a
  dmz-private-2c              = module.vpc.dmz-private-2c
  wechicken_master_username   = var.wechicken_master_username
  wechicken_master_password   = var.wechicken_master_password
}
