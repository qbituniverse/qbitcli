[CmdletBinding()]
Param
(
    [Parameter(Position=0,Mandatory=$false,HelpMessage="Operation: --view")]
    [string]$Operation
)

If ($Operation -in "--help") {
    Write-Host -ForegroundColor Green ""
    Write-Host -ForegroundColor Green "Helm Environment:"
    Write-Host -ForegroundColor Green ""
    Write-Host -ForegroundColor Green " [operation]"
    Write-Host -ForegroundColor Green ""
    Write-Host -ForegroundColor Green " --view          View all Helm resources"
    Write-Host -ForegroundColor Green ""
    Write-Host -ForegroundColor Green ""
    Write-Host -ForegroundColor Green "Usage:"
    Write-Host -ForegroundColor Green "             helm.ps1 [operation]"
    Write-Host -ForegroundColor Green ""
    Exit
}

If ($Operation -in ("--view", "")) {
    Write-Host -ForegroundColor Green "=========================================================="
    Write-Host -ForegroundColor Green "Current Context"
    Write-Host -ForegroundColor Green "=========================================================="
    
    kubectl config get-contexts

    Write-Host ""
    Write-Host -ForegroundColor Green "=========================================================="
    Write-Host -ForegroundColor Green "Releases"
    Write-Host -ForegroundColor Green "=========================================================="
    
    helm list --all --all-namespaces

    Write-Host ""
    Write-Host -ForegroundColor Green "=========================================================="
    Write-Host -ForegroundColor Green "Repositories"
    Write-Host -ForegroundColor Green "=========================================================="
    
    helm repo list

    Write-Host ""
    Write-Host -ForegroundColor Green "=========================================================="
    Write-Host -ForegroundColor Green "Plugins"
    Write-Host -ForegroundColor Green "=========================================================="
    
    helm plugin list

    Write-Host ""
} Else {
    Write-Host -ForegroundColor Red "=========================================================="
    Write-Host -ForegroundColor Red "Wrong Operation Received"
    Write-Host -ForegroundColor Red "Use: --view"
    Write-Host -ForegroundColor Red "=========================================================="
}
