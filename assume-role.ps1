$ErrorActionPreference = "Stop"
$jsonpayload = [Console]::In.ReadLine()
$json = ConvertFrom-Json $jsonpayload
$cli_json = $json.cli_json | ConvertTo-Json
$policy = $json.policy | ConvertTo-Json

$ErrorActionPreference = "Continue"
$aws_output = aws sts assume-role --output json --cli-input-json "$cli_json" $(if ($json.policy) { '--policy', $policy }) $(if ($json.profile) { '--profile', $json.profile }) 2>&1 | Out-String

$ErrorActionPreference = "Stop"
try {
    ConvertFrom-Json $aws_output | Out-Null
}
catch {
    $exit_code = $LASTEXITCODE
    Write-Error "$aws_output"
    exit $exit_code
}
@{
    output = "$aws_output"
} | ConvertTo-Json
