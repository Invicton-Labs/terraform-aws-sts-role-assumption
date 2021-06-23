terraform {}

locals {
    is_windows                   = dirname("/") == "\\"
}
data "external" "assumed_role_creds" {
  program = local.is_windows ? ["Powershell.exe", "${path.module}/assume-role.ps1"] : ["bash", "${path.module}/assume-role.sh"]
  query = {
    external_id = var.external_id
    policy = replace(replace(replace(var.policy, "\n", ""), "\r", ""), "\"", "__TF_MAGIC_QUOTE_STRING")
    profile  = var.profile
    role_arn = var.role_arn
    session_name  = var.session_name != null ? var.session_name : uuid()
    session_duration = var.session_duration
  }
}

locals {
    result = jsondecode(data.external.assumed_role_creds.result.output)
}
