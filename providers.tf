provider "aws" {
  alias  = "backup"
  region = "ap-south-1"
  assume_role {
    role_arn = "arn:aws:iam::${var.backup_account_id}:role/OrganizationAccountAccessRole"
  }
}
