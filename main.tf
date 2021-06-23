terraform {}

locals {
  is_windows        = dirname("/") == "\\"
  role_session_name = var.role_session_name != null ? var.role_session_name : uuid()
  policy_arns = [
    for policy_arn in var.policy_arns :
    {
      arn = policy_arn
    }
  ]
  tags = [
    for k, v in var.tags :
    {
      Key   = k
      Value = v
    }
  ]

  cli_json = merge({
    RoleArn           = var.role_arn
    RoleSessionName   = local.role_session_name
    PolicyArns        = local.policy_arns
    DurationSeconds   = var.duration_seconds
    Tags              = local.tags
    TransitiveTagKeys = var.transitive_tag_keys
    }, var.external_id != null ? {
    ExternalId = var.external_id
    } : {}, var.serial_number != null ? {
    SerialNumber = var.serial_number
    } : {}, var.token_code != null ? {
    TokenCode = var.token_code
  } : {})
}
data "external" "assumed_role_creds" {
  program = local.is_windows ? ["Powershell.exe", "${path.module}/assume-role.ps1"] : ["bash", "${path.module}/assume-role.sh"]
  query = {
    cli_json = local.is_windows ? jsonencode(local.cli_json) : replace(jsonencode(local.cli_json), "\"", "__TF_MAGIC_QUOTE_STRING")
    policy   = local.is_windows ? replace(replace(var.policy, "\n", ""), "\r", "") : replace(replace(replace(var.policy, "\n", ""), "\r", ""), "\"", "__TF_MAGIC_QUOTE_STRING")
    profile  = var.profile
  }
}

locals {
  result = jsondecode(data.external.assumed_role_creds.result.output)
}
