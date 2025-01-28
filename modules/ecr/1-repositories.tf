resource "aws_ecr_repository" "repositories" {
  for_each = toset(var.repositories)
  name = each.value

  image_scanning_configuration {
    scan_on_push = true
  }

  image_tag_mutability = "MUTABLE"
  tags = {
    BuildType = "Production"
    Project = "frameshot"
  }
}