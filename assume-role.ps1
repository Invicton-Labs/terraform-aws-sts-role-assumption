$ErrorActionPreference = "Stop"
$jsonpayload = [Console]::In.ReadLine()
$json = ConvertFrom-Json $jsonpayload

aws sts assume-role --role-arn $json.iam_role --role-session-name $json.session_name --duration-seconds $json.session_duration --profile $json.profile --output json
