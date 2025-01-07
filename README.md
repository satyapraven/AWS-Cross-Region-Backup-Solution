# AWS Cross-Region Backup Solution

This Terraform configuration sets up automated cross-region backups for EC2 instances and RDS databases using AWS Backup service with SNS notifications.

## Prerequisites

- AWS Organizations already set up
- Backup account created under the organization
- Resources tagged with `Backup = yes`
- Appropriate IAM roles and permissions

## Backup Configuration

### Source to Destination Mapping
- ap-south-1 → ap-south-2 (Backup account)
- ap-southeast-1 → ap-south-1 (Backup account)

### Schedule and Retention
- Backup Time: 12:00 PM IST (Daily)
- Retention Period: 365 days

## Notifications

Backup status notifications are configured via SNS for the following events:
- Backup job started/completed/failed
- Copy job started/completed/failed

## Resource Selection

Resources are selected for backup based on tags:
```
Key: Backup
Value: yes
```

## Project Structure

```
.
├── main.tf                 # Main configuration
├── providers.tf            # AWS provider configuration
├── variables.tf            # Input variables
└── modules/
    ├── backup/            # Main backup module
    ├── backup_plan/       # Backup plan configuration
    └── backup_vault/      # Backup vault and notifications
```

## Usage

1. Set your backup account ID:
```hcl
backup_account_id = "your-backup-account-id"
```

2. Initialize Terraform:
```bash
terraform init
```

3. Apply the configuration:
```bash
terraform apply
```

4. Subscribe to the SNS topic for notifications

## Monitoring

Monitor backup jobs through:
- SNS notifications
- AWS Backup dashboard
- AWS CloudWatch
- AWS Backup audit manager

## Security

- Cross-account backups for isolation
- Cross-region copies for disaster recovery
- Tag-based selection for controlled backups
- SNS notifications for backup status monitoring