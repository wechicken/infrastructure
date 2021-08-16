resource "aws_ecs_cluster" "wechicken" {
  name = "Wechicken"

  tags = { Name = "Wechicken Cluster" }
}

resource "aws_ecs_task_definition" "wechicken-development" {
  family = "wechicken-development"
  network_mode = "awsvpc"
  requires_compatibilities = [ "FARGATE" ]
  cpu = "256"
  memory = "512"
  execution_role_arn = var.iam-role-ecs.arn

  container_definitions = <<EOF
[
  {
    "name": "wechicken-development",
    "image": "${var.wechicken-repository.repository_url}:development",
    "memory": 512,
    "networkMode": "awsvpc",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "ecs/wechicken-development",
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

resource "aws_ecs_service" "wechicken-development" {
  name = "wechicken-development"
  cluster = aws_ecs_cluster.wechicken.id
  task_definition = aws_ecs_task_definition.wechicken-development.arn
  desired_count = 1
  launch_type = "FARGATE"

  network_configuration {
    security_groups = [var.allow-web.id]
    subnets = [var.dmz-public-2a.id, var.dmz-public-2c.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.wechicken-dev-target-group.arn
    container_name = "wechicken-development"
    container_port = 80
  }

  depends_on = [
    var.wechicken-dev-listener
  ]
}

resource "aws_cloudwatch_log_group" "wechicken-dev-logs" {
  name = "ecs/wechicken-development"
}
