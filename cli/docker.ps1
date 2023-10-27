[CmdletBinding()]
Param
(
	[Parameter(Position=0,Mandatory=$true,HelpMessage="Operation: --h | --v | --pd | --pu | --pai | --pav | --pan | --pac | --p-all")]
	[string]$Operation,
	[Parameter(Position=1,Mandatory=$false,HelpMessage="Switch: --s")]
	[string]$Switch
)

$AddSudo = $false;

If ($Switch -in "--s") { $AddSudo = $true }

If ($Operation -in "--h") {
	Write-Host -ForegroundColor Green ""
	Write-Host -ForegroundColor Green "Docker Environment:"
	Write-Host -ForegroundColor Green ""
	Write-Host -ForegroundColor Green "	[operation]"
	Write-Host -ForegroundColor Green ""
	Write-Host -ForegroundColor Green "	--h 			Help."
	Write-Host -ForegroundColor Green "	--v 			View all docker resources: system stats, network, all images, all containers, all volumes, dangling volumes, dangling images."
	Write-Host -ForegroundColor Green "	--pd			Prune dangling volumes & images."
	Write-Host -ForegroundColor Green "	--pu			Prune unused volumes, images & networks."
	Write-Host -ForegroundColor Green "	--pai			Prune all images."
	Write-Host -ForegroundColor Green "	--pav			Prune all volumes."
	Write-Host -ForegroundColor Green "	--pan			Prune all networks."
	Write-Host -ForegroundColor Green "	--pac			Prune all containers."
	Write-Host -ForegroundColor Green "	--p-all			Prune entire system."
	Write-Host -ForegroundColor Green ""
	Write-Host -ForegroundColor Green "	[switch]"
	Write-Host -ForegroundColor Green "	--s 			Sudo switch enable for linux."
	Write-Host -ForegroundColor Green ""
	Write-Host -ForegroundColor Green "Usage:"
	Write-Host -ForegroundColor Green "				docker.ps1 [operation] [switch]"
	Write-Host -ForegroundColor Green ""
	Exit
} ElseIf ($Operation -eq "--v") {
	Write-Host -ForegroundColor Green "=========================================================="
	Write-Host -ForegroundColor Green "System"
	Write-Host -ForegroundColor Green "=========================================================="
	
	If ($AddSudo) { sudo } docker system df
	
	Write-Host ""
	Write-Host -ForegroundColor Green "=========================================================="
	Write-Host -ForegroundColor Green "Networks"
	Write-Host -ForegroundColor Green "=========================================================="
	
	If ($AddSudo) { sudo } docker network list
	
	Write-Host ""
	Write-Host -ForegroundColor Green "=========================================================="
	Write-Host -ForegroundColor Green "All Images"
	Write-Host -ForegroundColor Green "=========================================================="
	
	If ($AddSudo) { sudo } docker images
	
	Write-Host ""
	Write-Host -ForegroundColor Green "=========================================================="
	Write-Host -ForegroundColor Green "All Containers"
	Write-Host -ForegroundColor Green "=========================================================="
	
	If ($AddSudo) { sudo } docker ps -a
	
	Write-Host ""
	Write-Host -ForegroundColor Green "=========================================================="
	Write-Host -ForegroundColor Green "All Volumes"
	Write-Host -ForegroundColor Green "=========================================================="
	
	If ($AddSudo) { sudo } docker volume ls
	
	Write-Host ""
	Write-Host -ForegroundColor Red "=========================================================="
	Write-Host -ForegroundColor Red "Dangling Images"
	Write-Host -ForegroundColor Red "=========================================================="
	
	If ($AddSudo) { sudo } docker images -f dangling=true
	
	Write-Host ""
	Write-Host -ForegroundColor Red "=========================================================="
	Write-Host -ForegroundColor Red "Dangling Volumes"
	Write-Host -ForegroundColor Red "=========================================================="
	
	If ($AddSudo) { sudo } docker volume ls -f dangling=true
	
	Write-Host ""
} ElseIf ($Operation -eq "--pd") {
	Write-Host -ForegroundColor Red "=========================================================="
	Write-Host -ForegroundColor Red "Removing Dangling Volumes"
	Write-Host -ForegroundColor Red "=========================================================="
	
	If ($AddSudo) { sudo } docker volume rm -f $(docker volume ls -qf dangling=true)
	
	Write-Host -ForegroundColor Red "=========================================================="
	Write-Host -ForegroundColor Red "Removing Dangling Images"
	Write-Host -ForegroundColor Red "=========================================================="
	
	If ($AddSudo) { sudo } docker rmi -f $(docker images -qf dangling=true)

	Write-Host ""
} ElseIf ($Operation -eq "--pu") {
	Write-Host -ForegroundColor Red "=========================================================="
	Write-Host -ForegroundColor Red "Removing Unused Volumes"
	Write-Host -ForegroundColor Red "=========================================================="
	
	If ($AddSudo) { sudo } docker volume prune -f

	Write-Host ""
	Write-Host -ForegroundColor Red "=========================================================="
	Write-Host -ForegroundColor Red "Removing Unused Images"
	Write-Host -ForegroundColor Red "=========================================================="
	
	If ($AddSudo) { sudo } docker image prune -af

	Write-Host ""
	Write-Host -ForegroundColor Red "=========================================================="
	Write-Host -ForegroundColor Red "Removing Unused Networks"
	Write-Host -ForegroundColor Red "=========================================================="
	
	If ($AddSudo) { sudo } docker network prune -f

	Write-Host ""
} ElseIf ($Operation -eq "--pai") {
	Write-Host -ForegroundColor Red "=========================================================="
	Write-Host -ForegroundColor Red "Removing All Images"
	Write-Host -ForegroundColor Red "=========================================================="
	
	If ($AddSudo) { sudo } docker rmi -f $(docker images -qf dangling=true)
	If ($AddSudo) { sudo } docker rmi -f $(docker images -q)
	If ($AddSudo) { sudo } docker image prune -af

	Write-Host ""
} ElseIf ($Operation -eq "--pav") {
	Write-Host -ForegroundColor Red "=========================================================="
	Write-Host -ForegroundColor Red "Removing All Volumes"
	Write-Host -ForegroundColor Red "=========================================================="
	
	If ($AddSudo) { sudo } docker volume rm (docker volume ls -qf dangling=true)
	If ($AddSudo) { sudo } docker volume rm $(docker volume ls)
	If ($AddSudo) { sudo } docker volume prune -f

	Write-Host ""
} ElseIf ($Operation -eq "--pan") {
	Write-Host -ForegroundColor Red "=========================================================="
	Write-Host -ForegroundColor Red "Removing All Networks"
	Write-Host -ForegroundColor Red "=========================================================="
	
	If ($AddSudo) { sudo } docker network prune -f

	Write-Host ""
} ElseIf ($Operation -eq "--pac") {
	Write-Host -ForegroundColor Red "=========================================================="
	Write-Host -ForegroundColor Red "Removing All Containers"
	Write-Host -ForegroundColor Red "=========================================================="
	
	If ($AddSudo) { sudo } docker rm -fv $(docker ps -aq)

	Write-Host ""
} ElseIf ($Operation -eq "--p-all") {
	Write-Host -ForegroundColor Red "=========================================================="
	Write-Host -ForegroundColor Red "Removing All Containers"
	Write-Host -ForegroundColor Red "=========================================================="
	
	If ($AddSudo) { sudo } docker rm -fv $(docker ps -aq)

	Write-Host -ForegroundColor Red "=========================================================="
	Write-Host -ForegroundColor Red "Removing All Images"
	Write-Host -ForegroundColor Red "=========================================================="
	
	If ($AddSudo) { sudo } docker rmi -f $(docker images -qf dangling=true)
	If ($AddSudo) { sudo } docker rmi -f $(docker images -q)
	If ($AddSudo) { sudo } docker image prune -af

	Write-Host -ForegroundColor Red "=========================================================="
	Write-Host -ForegroundColor Red "Removing All Volumes"
	Write-Host -ForegroundColor Red "=========================================================="
	
	If ($AddSudo) { sudo } docker volume rm (docker volume ls -qf dangling=true)
	If ($AddSudo) { sudo } docker volume rm $(docker volume ls)
	If ($AddSudo) { sudo } docker volume prune -f

	Write-Host ""
	Write-Host -ForegroundColor Red "=========================================================="
	Write-Host -ForegroundColor Red "Removing All Networks"
	Write-Host -ForegroundColor Red "=========================================================="
	
	If ($AddSudo) { sudo } docker network prune -f

	Write-Host ""
} Else {
	Write-Host -ForegroundColor Red "=========================================================="
	Write-Host -ForegroundColor Red "Expected Operation Parameters"
	Write-Host -ForegroundColor Red "Use: --h | --v | --pd | --pu | --pai | --pav | --pan | --pac | --p-all"
	Write-Host -ForegroundColor Red ""
	Write-Host -ForegroundColor Red "Expected Switch Parameters"
	Write-Host -ForegroundColor Red "Use: --s"
	Write-Host -ForegroundColor Red ""
	Write-Host -ForegroundColor Red "For Help run: docker.ps1 --h"
	Write-Host -ForegroundColor Red "=========================================================="
}
