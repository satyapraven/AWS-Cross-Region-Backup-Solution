resource "aws_backup_vault" "backup_vault" {
  name = "cross-region-backup-vault"
  
  tags = {
    Environment = "Production"
  }
}