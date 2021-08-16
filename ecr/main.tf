resource "aws_ecr_repository" "wechicken-repository" {
  name                 = "wechicken"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }

  tags = {
    Name = "Wechicken ECR Repo"
  }
}
