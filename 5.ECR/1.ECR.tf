resource "aws_ecr_repository" "ecr_main" {
  name                 = lower(var.ecrname)

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = var.default_tag
}

############ Output Part ############
output "ecr_uri"{
  description = "URI of the ECR repository"
  value       = aws_ecr_repository.ecr_main.repository_url
}