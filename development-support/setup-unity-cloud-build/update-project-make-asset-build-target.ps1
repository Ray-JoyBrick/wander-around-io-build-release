param (
    [string]$apiKey = "",
    [string]$orgId = "",
    [string]$projectId = ""
 )

$header = @{"Authorization" = "Bearer $apiKey"}
$url = "https://build-api.cloud.unity3d.com/api/v1/orgs/$orgId/projects/$projectId/buildtargets"
$sourceFilePath = "update-project-make-asset-build-target.json"
$json = (Get-Content -Raw $sourceFilePath).psobject.baseobject | ConvertFrom-Json | ConvertTo-Json

$response = 
  Invoke-WebRequest `
    -Headers $header `
    -Method PUT `
    -Uri $url `
    -ContentType "application/json" `
    -Body $json

"$response"
