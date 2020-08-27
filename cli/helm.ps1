[CmdletBinding()]
Param
(
	[Parameter(Position=0,Mandatory=$false,HelpMessage="Operation: --view | --init")]
	[string]$Operation
)

If ($Operation -in "--help") {
	Write-Host -ForegroundColor Green ""
	Write-Host -ForegroundColor Green "Helm Environment:"
	Write-Host -ForegroundColor Green ""
	Write-Host -ForegroundColor Green "	[operation]"
	Write-Host -ForegroundColor Green ""
	Write-Host -ForegroundColor Green "	--view			View all Helm resources"
    Write-Host -ForegroundColor Green "	--init			Upgrade Helm on the cluster"
	Write-Host -ForegroundColor Green ""
	Write-Host -ForegroundColor Green ""
	Write-Host -ForegroundColor Green "Usage:"
	Write-Host -ForegroundColor Green "				helm.ps1 [operation]"
	Write-Host -ForegroundColor Green ""
	Exit
}

If ($Operation -in ("--view", "")) {
	Write-Host -ForegroundColor Green "=========================================================="
	Write-Host -ForegroundColor Green "Current Azure Subscription"
	Write-Host -ForegroundColor Green "=========================================================="
	
	az account show --query "name" --output tsv

	Write-Host ""
	Write-Host -ForegroundColor Green "=========================================================="
	Write-Host -ForegroundColor Green "ACR Repository Helm Charts"
	Write-Host -ForegroundColor Green "=========================================================="
	
	az acr helm list

	Write-Host ""
} ElseIf ($Operation -eq "--init") {
	Write-Host -ForegroundColor Red "=========================================================="
	Write-Host -ForegroundColor Red "Upgrading Helm on the Cluster"
	Write-Host -ForegroundColor Red "=========================================================="
	
	helm init --upgrade

	Write-Host ""
} Else {
	Write-Host -ForegroundColor Red "=========================================================="
	Write-Host -ForegroundColor Red "Wrong Operation Received"
	Write-Host -ForegroundColor Red "Use: --view | --init"
	Write-Host -ForegroundColor Red "=========================================================="
}
