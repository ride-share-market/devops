# AWS S3 Backups

## Overview

This document will describe the steps for creating:

1. An AWS S3 bucket for backup files (private bucket by default).
2. An AWS IAM Backup user account
3. An AWS S3 Backup write only policy for the backup user account.

## Procedure

The work dir for these steps is `app/kitchen`

Create AWS S3 bucket for backup files

- `aws s3api create-bucket --bucket rsmcom-backup`

Create an AWS IAM backup user account:

- `aws iam create-user --user-name backup`

Create a set of access keys for the new backup IAM user account:

- `aws iam create-access-key --user-name backup`

*Save the AccessKeyId and SecretAccessKey to the RSM keepass database file.*

Create an IAM S3 policy for write only access the the rsmcom-backup bucket

- `aws iam create-policy --policy-name AmazonS3BackupWriteOnlyAccess --policy-document file://./aws/iam_s3_backup_policy.json`

Export to a shell environment variable the Arn ID:

- `export IAM_S3_BACKUP_POLICY_ARN="arn:aws:iam::xxx-xxx-xxx-xxx:policy/AmazonS3BackupWriteOnlyAccess"`

Attach the S3 backup write only policy to the new backup user account:

- `aws iam attach-user-policy --policy-arn $IAM_S3_BACKUP_POLICY_ARN --user-name backup`

## Summary

You know have access credentials for a backup account that can write only to the backup S3 bucket.

Use the access credentials in application backup scripts.
