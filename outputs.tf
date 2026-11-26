output "kms_key" {
  description = "The KMS customer master key to encrypt state buckets."
  value       = aws_kms_key.this
}

output "kms_key_alias" {
  description = "The alias of the KMS customer master key used to encrypt state bucket."
  value       = aws_kms_alias.this
}

output "state_bucket" {
  description = "The S3 bucket to store the remote state file."
  value = {
    arn                         = aws_s3_bucket.state.arn
    bucket                      = aws_s3_bucket.state.bucket
    bucket_domain_name          = aws_s3_bucket.state.bucket_domain_name
    bucket_prefix               = aws_s3_bucket.state.bucket_prefix
    bucket_region               = aws_s3_bucket.state.bucket_region
    bucket_regional_domain_name = aws_s3_bucket.state.bucket_regional_domain_name
    force_destroy               = aws_s3_bucket.state.force_destroy
    hosted_zone_id              = aws_s3_bucket.state.hosted_zone_id
    id                          = aws_s3_bucket.state.id
    object_lock_enabled         = aws_s3_bucket.state.object_lock_enabled
    region                      = aws_s3_bucket.state.region
    tags                        = aws_s3_bucket.state.tags
    tags_all                    = aws_s3_bucket.state.tags_all
  }
}

output "replica_bucket" {
  description = "The S3 bucket to replicate the state S3 bucket."
  value = var.enable_replication ? {
    arn                         = aws_s3_bucket.replica[0].arn
    bucket                      = aws_s3_bucket.replica[0].bucket
    bucket_domain_name          = aws_s3_bucket.replica[0].bucket_domain_name
    bucket_prefix               = aws_s3_bucket.replica[0].bucket_prefix
    bucket_region               = aws_s3_bucket.replica[0].bucket_region
    bucket_regional_domain_name = aws_s3_bucket.replica[0].bucket_regional_domain_name
    force_destroy               = aws_s3_bucket.replica[0].force_destroy
    hosted_zone_id              = aws_s3_bucket.replica[0].hosted_zone_id
    id                          = aws_s3_bucket.replica[0].id
    object_lock_enabled         = aws_s3_bucket.replica[0].object_lock_enabled
    region                      = aws_s3_bucket.replica[0].region
    tags                        = aws_s3_bucket.replica[0].tags
    tags_all                    = aws_s3_bucket.replica[0].tags_all
  } : null
}

output "kms_key_replica" {
  description = "The KMS customer master key to encrypt replica bucket."
  value       = try(aws_kms_key.replica[0], null)
}

output "terraform_iam_policy" {
  description = "The IAM Policy to access remote state environment."
  value       = var.terraform_iam_policy_create ? aws_iam_policy.terraform[0] : null
}
