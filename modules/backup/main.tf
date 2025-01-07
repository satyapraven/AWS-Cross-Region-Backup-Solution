module "backup_vault" {
  source = "../backup_vault"
}

module "backup_plan_ap_south_1" {
  source = "../backup_plan"
  
  plan_name          = "ap-south-1-backup-plan"
  vault_arn          = module.backup_vault.vault_arn
  vault_name         = module.backup_vault.vault_name
  destination_region = "ap-south-2"
  schedule          = "cron(0 6 30 * ? *)" # 12:00 PM IST
  retention_days    = 365
}