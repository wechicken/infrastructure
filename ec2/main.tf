resource "aws_alb" "wechicken-dev-alb" {
  name            = "alb-dev"
  internal        = false
  security_groups = ["${var.security-group-allow-web.id}"]
  subnets         = [
    var.dmz-public-2a.id,
    var.dmz-public-2c.id
  ]

  tags = { Name = "Wechicken-dev ALB" }

  lifecycle { create_before_destroy = true }
}

resource "aws_alb_target_group" "wechicken-dev-target-group" {
  name     = "wechicken-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc-dmz.id
  target_type = "ip"

  health_check {
    interval            = 30
    path                = "/"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
  }

  tags = { Name = "Wechicken-dev ALB Target Group" }
}

resource "aws_alb_listener" "wechicken-dev-listener" {
  load_balancer_arn = aws_alb.wechicken-dev-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.wechicken-dev-target-group.arn
    type             = "forward"
  }
}
