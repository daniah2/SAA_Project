resource "aws_secretsmanager_secret" "database-username-secret" {
  name                    = "database-username-secret"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "database-username-secret-value" {
  secret_id     = aws_secretsmanager_secret.database-username-secret.id
  secret_string = var.database-username
}

resource "aws_secretsmanager_secret" "database-password-secret" {
  name                    = "database-password-secret"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "database-password-secret-value" {
  secret_id     = aws_secretsmanager_secret.database-password-secret.id
  secret_string = var.database-password
}
