# AWS STS Role Assumption module
A module that uses a data resource (runs on every plan step) to assume a role using STS and return a temporary access key. This is particularly useful when you need to use external scripts (AWS CLI) to perform actions that can't be done via the Terraform AWS provider; you can use this module to retrieve temporary credentials, then set them in the environment variables for the external script you need to run.

## Variables
The input variables are the same as those for the `aws sts assume-role` [CLI command](https://docs.aws.amazon.com/cli/latest/reference/sts/assume-role.html), although are provided in snake case.
