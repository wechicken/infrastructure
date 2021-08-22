resource "aws_ecs_cluster" "cluster" {
  name = "${var.cluster-name}"

  tags = { Name = "${var.cluster-name} cluster" }
}
