output "target-group" {
  value = aws_alb_target_group.alb-target-group
}

output "listener" {
  value = aws_alb_listener.alb-listener
}
