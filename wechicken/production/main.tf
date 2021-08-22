module "alb" {
  source = "../../alb"

  security-group-allow-web = var.security-groups-allow-web
  vpc-dmz = var.vpc-dmz
  dmz-public-2a = var.dmz-public-2a
  dmz-public-2c = var.dmz-public-2c
  alb-name = "wechicken-production"
}

resource "aws_ecs_service" "service" {
  name = "${var.name}-production"
  cluster = var.cluster.id
  task_definition = aws_ecs_task_definition.task-denifition.arn
  desired_count = var.desired-capacity
  launch_type = "FARGATE"

  network_configuration {
    security_groups = [var.security-groups-allow-web.id]
    subnets = [var.dmz-public-2a.id, var.dmz-public-2c.id]
    assign_public_ip = true
  }

  load_balancer {
    container_name = "${var.name}-production"
    container_port = 80
    target_group_arn = module.alb.target-group.arn
  }

  depends_on = [
    module.alb.listener
  ]
}

resource "aws_ecs_task_definition" "task-denifition" {
  family = "${var.name}-production"
  network_mode = "awsvpc"
  requires_compatibilities = [ "FARGATE" ]
  cpu = "256"
  memory = "512"
  execution_role_arn = var.iam-role-ecs.arn

  container_definitions = <<EOF
[
  {
    "name": "${var.name}-production",
    "image": "${var.repository.repository_url}:production",
    "memory": 512,
    "networkMode": "awsvpc",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${aws_cloudwatch_log_group.log-group.name}",
        "awslogs-region": "ap-northeast-2",
        "awslogs-stream-prefix": "fargate"
      }
    },
    "portMappings": [
      {
        "protocol": "tcp",
        "containerPort": 80,
        "hostPort": 80
      }
    ]
  }
]
EOF
}

resource "aws_cloudwatch_log_group" "log-group" {
  name = "/ecs/${var.name}-production"
}
