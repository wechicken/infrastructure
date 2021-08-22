variable "name" {
  description = "name of the project"
}

variable "security-groups-allow-web" {
  description = "security-groups-allow-web"
}

variable "vpc-dmz" {
  description = "vpc-dmz"
}

variable "dmz-public-2a" {
  description = "dmz-public-2a"
}

variable "dmz-public-2c" {
  description = "dmz-public-2c"
}

variable "iam-role-ecs" {
  description = "iam-role-ecs"
}

variable "repository" {
  description = "ecr-repository"
}

variable "cluster" {
  description = "ecs-cluster"
}

variable "desired-capacity" {
  description = "scs-service-desired-count"
}
