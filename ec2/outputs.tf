output "wechicken-dev-target-group" {
  value = aws_alb_target_group.wechicken-dev-target-group
}

output "wechicken-dev-listener" {
  value = aws_alb_listener.wechicken-dev-listener
}
