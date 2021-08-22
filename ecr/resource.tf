resource "aws_ecr_repository" "repository" {
  name                 = var.repository-name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }

  tags = {
    Name = "${var.repository-name} ECR Repo"
  }
}
