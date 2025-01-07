resource "aws_backup_vault" "backup_vault" {
  name = "cross-region-backup-vault"
  
  tags = {
    Environment = "Production"
  }
}

resource "aws_sns_topic" "backup_notifications" {
  name = "backup-notifications"
}

resource "aws_sns_topic_policy" "backup_notifications" {
  arn = aws_sns_topic.backup_notifications.arn
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "backup.amazonaws.com"
        }
        Action = "SNS:Publish"
        Resource = aws_sns_topic.backup_notifications.arn
      }
    ]
  })
}

resource "aws_backup_vault_notifications" "backup_notifications" {
  backup_vault_name   = aws_backup_vault.backup_vault.name
  sns_topic_arn      = aws_sns_topic.backup_notifications.arn
  
  backup_vault_events = [
    "BACKUP_JOB_STARTED",
    "BACKUP_JOB_COMPLETED",
    "BACKUP_JOB_FAILED",
    "COPY_JOB_STARTED",
    "COPY_JOB_COMPLETED",
    "COPY_JOB_FAILED"
  ]
}

output "sns_topic_arn" {
  value = aws_sns_topic.backup_notifications.arn
}