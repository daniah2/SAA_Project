resource "aws_ssm_parameter" "backend-port" {
  name  = "backend-port"
  type  = "String"
  value = var.backend-port
}

resource "aws_ssm_parameter" "database-name" {
  name  = "database-name"
  type  = "String"
  value = var.database-name
}

resource "aws_ssm_parameter" "database-port" {
  name  = "database-port"
  type  = "String"
  value = var.database-port
}
