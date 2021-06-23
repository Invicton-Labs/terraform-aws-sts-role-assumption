variable "role_arn" {
  description = "The Amazon Resource Name (ARN) of the role to assume."
  type        = string
}

variable "role_session_name" {
  description = "(Optional) An identifier for the assumed role session."
  type        = string
  default     = null
}

variable "policy_arns" {
  description = "(Optional) The Amazon Resource Names (ARNs) of the IAM managed policies that you want to use as managed session policies. The policies must exist in the same account as the role."
  type        = list(string)
  default     = []
  validation {
    condition     = length(var.policy_arns) <= 10
    error_message = "No more than 10 policy ARNs may be specified."
  }
}

variable "policy" {
  description = "(Optional) An IAM policy in JSON format that you want to use as an inline session policy."
  type        = string
  default     = ""
}

variable "duration_seconds" {
  description = "(Optional) The duration, in seconds, of the role session. The value specified can can range from 900 seconds (15 minutes) up to the maximum session duration that is set for the role. Defaults to 3600 (1 hour)."
  type        = number
  default     = 3600
}

variable "tags" {
  description = "(Optional) A list of session tags that you want to pass. Each session tag consists of a key name and an associated value."
  type        = map(string)
  default     = {}
  validation {
    condition     = length(var.tags) <= 50
    error_message = "No more than 50 tags may be specified."
  }
}

variable "transitive_tag_keys" {
  description = "(Optional) A list of keys for session tags that you want to set as transitive. If you set a tag key as transitive, the corresponding key and value passes to subsequent sessions in a role chain."
  type        = list(string)
  default     = []
  validation {
    condition     = length(var.transitive_tag_keys) <= 50
    error_message = "No more than 50 transitive tag key may be specified."
  }
}

variable "external_id" {
  description = "(Optional) The external ID to use for assuming the role."
  type        = string
  default     = null
}

variable "serial_number" {
  description = "(Optional) The identification number of the MFA device that is associated with the user who is making the AssumeRole call. Specify this value if the trust policy of the role being assumed includes a condition that requires MFA authentication. The value is either the serial number for a hardware device (such as `GAHT12345678`) or an Amazon Resource Name (ARN) for a virtual device (such as `arn:aws:iam::123456789012:mfa/user`)."
  type        = string
  default     = null
}

variable "token_code" {
  description = "(Optional) The value provided by the MFA device, if the trust policy of the role being assumed requires MFA. (In other words, if the policy includes a condition that tests for MFA). If the role being assumed requires MFA and if the TokenCode value is missing or expired, the `AssumeRole` call returns an \"access denied\" error."
  type        = string
  default     = null
}

variable "profile" {
  description = "(Optional) The AWS profile to use to assume the role. If not provided, it will attempt to use the environment variables that Terraform is using (hoping that AWS_PROFILE, AWS_ACCESS_KEY_ID, etc. have been set)"
  type        = string
  default     = ""
}
