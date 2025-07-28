
resource "aws_ecr_repository" "repo" {
  name = var.name
}

output "repository_url" {
  value = aws_ecr_repository.repo.repository_url
}
