resource "aws_alb" "alb" {
  name            = var.alb-name
  internal        = false
  security_groups = ["${var.security-group-allow-web.id}"]
  subnets         = [
    var.dmz-public-2a.id,
    var.dmz-public-2c.id
  ]

  tags = { Name = "${var.alb-name} ALB" }

  lifecycle { create_before_destroy = true }
}

resource "aws_alb_target_group" "alb-target-group" {
  name     = var.alb-name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc-dmz.id
  target_type = "ip"

  health_check {
    interval            = 60
    path                = "/"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
  }

  tags = { Name = "${var.alb-name} ALB Target Group" }
}

resource "aws_alb_listener" "alb-listener" {
  load_balancer_arn = aws_alb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.alb-target-group.arn
    type             = "forward"
  }
}
