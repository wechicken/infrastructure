resource "aws_rds_cluster" "wechicken-mysql" {
  cluster_identifier = "wechicken-mysql"
  master_username = var.wechicken_master_username
  master_password = var.wechicken_master_password

  engine = "aurora"
  engine_mode = "serverless"
  deletion_protection = true
  skip_final_snapshot = true
  vpc_security_group_ids = [var.security-groups-allow-mysql.id]
  db_subnet_group_name = aws_db_subnet_group.rds.name

  scaling_configuration {
    auto_pause = true
    min_capacity = 1
    max_capacity = 1
    seconds_until_auto_pause = 300
    timeout_action = "RollbackCapacityChange"
  }

  lifecycle {
    ignore_changes = [scaling_configuration[0].min_capacity]
  }

  tags = {
    Name = "Wechicken MySQL"
  }
}

resource "aws_db_subnet_group" "rds" {
  name       = "rds-subnet-groups"
  subnet_ids = [
    var.dmz-private-2a.id,
    var.dmz-private-2c.id
  ]

  tags = {
    Name = "Rds Subnet Groups"
  }
}
