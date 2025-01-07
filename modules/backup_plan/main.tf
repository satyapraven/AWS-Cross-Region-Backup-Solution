resource "aws_backup_plan" "backup_plan" {
  name = var.plan_name

  rule {
    rule_name         = "${var.plan_name}-rule"
    target_vault_name = var.vault_name
    schedule          = var.schedule

    lifecycle {
      delete_after = var.retention_days
    }

    copy_action {
      destination_vault_arn = var.vault_arn
      lifecycle {
        delete_after = var.retention_days
      }
    }
  }

  tags = {
    Environment = "Production"
  }
}

resource "aws_backup_selection" "backup_selection" {
  name         = "${var.plan_name}-selection"
  plan_id      = aws_backup_plan.backup_plan.id
  iam_role_arn = aws_iam_role.backup_role.arn

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "Backup"
    value = "yes"
  }
}