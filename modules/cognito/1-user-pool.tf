resource "aws_cognito_user_pool" "user_pool" {
  name = "${var.name}-user-pool"

  alias_attributes         = ["email"]
  auto_verified_attributes = ["email"]

  password_policy {
    minimum_length                   = 8
    require_uppercase                = true
    require_numbers                   = true
    require_symbols                   = true
    temporary_password_validity_days = 7
  }

  mfa_configuration = "OFF"

  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }
}