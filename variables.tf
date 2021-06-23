variable "role_arn" {
  description = "The ARN of the role to assume."
  type = string
}

variable "session_name" {
  description = "(Optional) A name to give to the session."
  type = string
  default = null
}

variable "profile" {
  description = "The AWS profile to use to assume the role."
  type = string
}

variable "session_duration" {
    description = "The number of seconds for the session to be valid for. Defaults to 3600 (1 hour)."
    type = number
    default = 3600
}

variable "external_id" {
  description = "The external ID to use for assuming the role."
  type = string
  default = ""
}

variable "policy" {
  description = "(Optional) An IAM policy in JSON format that you want to use as an inline session policy."
  type = string
  default = ""
}
