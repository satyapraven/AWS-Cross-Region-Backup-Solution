module "backup" {
  source = "./modules/backup"
  providers = {
    aws = aws.backup
  }
  backup_account_id = var.backup_account_id
}
