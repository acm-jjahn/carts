Param (
	[Parameter(Mandatory=$true)][string]$dtTenantUrl,
	[Parameter(Mandatory=$true)][string]$dtToken
)

$requestBody = @{
	"eventType" = "CUSTOM_DEPLOYMENT"
	"source" = "TFS"
	"deploymentName" = "myDeployment"
	"deploymentVersion" = "myVersion"
	"deploymentProject" = "myProject"
	"ciBackLink" = "myBackLink"
	"attachRules" = @{
			"tagRule" = @(
				@{
					"meTypes" = @(
						"HOST"
					)
					"tags" = @(
						@{
							"context" = "CONTEXTLESS"
							"key" = "Environment"
						}
					)
				}
			)
	}
} | ConvertTo-Json -Depth 5

Write-Host $requestBody
Write-Host $dtToken
Write-Host "$dtTenantUrl/api/v1/events"

Invoke-RestMethod -Uri "$dtTenantUrl/api/v1/events" -Method Post -Body $requestBody -ContentType "application/json" -Headers @{"Authorization" = "Api-Token $dtToken"}

	