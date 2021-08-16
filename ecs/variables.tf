variable "iam-role-ecs" {
  description = "iam-role-ecs"
}

variable "wechicken-repository" {
  description = "wechicken-repository"
}

variable "allow-web" {
  description = "security-group-allow-web"
}

variable "dmz-public-2a" {
  description = "dmz-public-2a"
}

variable "dmz-public-2c" {
  description = "dmz-public-2c"
}

variable "wechicken-dev-target-group" {
  description = "aws-alb-target-group-wechicken-dev-target-group"
}

variable "wechicken-dev-listener" {
  description = "aws-alb-listener-wechicken-dev-listener"
}
