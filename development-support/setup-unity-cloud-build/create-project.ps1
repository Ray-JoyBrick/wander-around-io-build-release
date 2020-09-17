param (
    [string]$apiKey = "",
    [string]$orgId = "",
    [string]$sourceFilePath = ""
 )

$header = @{"Authorization" = "Bearer $apiKey"}
$url = "https://build-api.cloud.unity3d.com/api/v1/orgs/$orgId/projects"
# $sourceFilePath = "create-project-make-asset.json"
$json = (Get-Content -Raw $sourceFilePath).psobject.baseobject | ConvertFrom-Json | ConvertTo-Json

$response = 
  Invoke-WebRequest `
    -Headers $header `
    -Method POST `
    -Uri $url `
    -ContentType "application/json" `
    -Body $json

"$response"
