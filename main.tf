terraform {
  required_version = "~>1.0"
}

provider "aws" {
  region    = "ap-northeast-2"
  profile   = "wechicken"
}

module "wechicken-development" {
  source = "./wechicken/development"
}

module "wechicken-production" {
  source = "./wechicken/production"
}
