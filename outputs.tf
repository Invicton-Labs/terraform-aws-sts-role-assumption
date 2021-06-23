output "access_key_id" {
  value = local.result.Credentials.AccessKeyId
}

output "expiration" {
  value = local.result.Credentials.Expiration
}

output "secret_access_key" {
  value = local.result.Credentials.SecretAccessKey
}

output "session_token" {
  value = local.result.Credentials.SessionToken
}

output "assumed_role_user_arn" {
  value = local.result.AssumedRoleUser.Arn
}

output "assumed_role_id" {
  value = local.result.AssumedRoleUser.AssumedRoleId
}