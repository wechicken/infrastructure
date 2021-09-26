variable "wechicken_master_username" {
  description = "wechicken_master_username"

  validation {
    condition     = length(var.wechicken_master_username) == 9
    error_message = "Wechicken_master_username length must be 9."
  }
}

variable "wechicken_master_password" {
  description = "wechicken_master_password"

  validation {
    condition     = length(var.wechicken_master_password) > 7
    error_message = "Wechicken_master_username length must be larger than 7."
  }
}
