[CmdletBinding()]
Param
(
	[Parameter(Position=0,Mandatory=$false,HelpMessage="Operation: --view | --pd | --pu | --pc | --pa")]
	[string]$Operation
)

If ($Operation -in "--help") {
	Write-Host -ForegroundColor Green ""
	Write-Host -ForegroundColor Green "Docker Environment:"
	Write-Host -ForegroundColor Green ""
	Write-Host -ForegroundColor Green "	[operation]"
	Write-Host -ForegroundColor Green ""
	Write-Host -ForegroundColor Green "	--view			View all docker resources: system stats, network, all images, all containers, all volumes, dangling volumes, dangling images."
	Write-Host -ForegroundColor Green "	--pd			Prune dangling volumes & images."
	Write-Host -ForegroundColor Green "	--pu			Prune unused volumes & images."
	Write-Host -ForegroundColor Green "	--pc			Prune containers."
	Write-Host -ForegroundColor Green "	--pa			Prune entire system."
	Write-Host -ForegroundColor Green ""
	Write-Host -ForegroundColor Green ""
	Write-Host -ForegroundColor Green "Usage:"
	Write-Host -ForegroundColor Green "				docker.ps1 [operation]"
	Write-Host -ForegroundColor Green ""
	Exit
}

If ($Operation -in ("--view", "")) {
	Write-Host -ForegroundColor Green "=========================================================="
	Write-Host -ForegroundColor Green "System"
	Write-Host -ForegroundColor Green "=========================================================="
	
	docker system df
	
	Write-Host ""
	Write-Host -ForegroundColor Green "=========================================================="
	Write-Host -ForegroundColor Green "Networks"
	Write-Host -ForegroundColor Green "=========================================================="
	
	docker network list
	
	Write-Host ""
	Write-Host -ForegroundColor Green "=========================================================="
	Write-Host -ForegroundColor Green "All Images"
	Write-Host -ForegroundColor Green "=========================================================="
	
	docker images
	
	Write-Host ""
	Write-Host -ForegroundColor Green "=========================================================="
	Write-Host -ForegroundColor Green "All Containers"
	Write-Host -ForegroundColor Green "=========================================================="
	
	docker ps -a
	
	Write-Host ""
	Write-Host -ForegroundColor Green "=========================================================="
	Write-Host -ForegroundColor Green "All Volumes"
	Write-Host -ForegroundColor Green "=========================================================="
	
	docker volume ls
	
	Write-Host ""
	Write-Host -ForegroundColor Red "=========================================================="
	Write-Host -ForegroundColor Red "Dangling Images"
	Write-Host -ForegroundColor Red "=========================================================="
	
	docker images -f dangling=true
	
	Write-Host ""
	Write-Host -ForegroundColor Red "=========================================================="
	Write-Host -ForegroundColor Red "Dangling Volumes"
	Write-Host -ForegroundColor Red "=========================================================="
	
	docker volume ls -f dangling=true
	
	Write-Host ""
} ElseIf ($Operation -eq "--pd") {
	Write-Host -ForegroundColor Red "=========================================================="
	Write-Host -ForegroundColor Red "Removing Dangling Volumes"
	Write-Host -ForegroundColor Red "=========================================================="
	
	docker volume rm -f $(docker volume ls -qf dangling=true)
	
	Write-Host -ForegroundColor Red "=========================================================="
	Write-Host -ForegroundColor Red "Removing Dangling Images"
	Write-Host -ForegroundColor Red "=========================================================="
	
	docker rmi -f $(docker images -qf dangling=true)

	Write-Host ""
} ElseIf ($Operation -eq "--pu") {
	Write-Host -ForegroundColor Red "=========================================================="
	Write-Host -ForegroundColor Red "Removing Unused Volumes"
	Write-Host -ForegroundColor Red "=========================================================="
	
	docker volume prune -f

	Write-Host ""
	Write-Host -ForegroundColor Red "=========================================================="
	Write-Host -ForegroundColor Red "Removing Unused Images"
	Write-Host -ForegroundColor Red "=========================================================="
	
	docker image prune -af

	Write-Host ""
} ElseIf ($Operation -eq "--pc") {
	Write-Host -ForegroundColor Red "=========================================================="
	Write-Host -ForegroundColor Red "Removing All Containers"
	Write-Host -ForegroundColor Red "=========================================================="
	
	docker rm -fv $(docker ps -aq)

	Write-Host ""
} ElseIf ($Operation -eq "--pa") {
	Write-Host -ForegroundColor Red "=========================================================="
	Write-Host -ForegroundColor Red "Removing All Containers"
	Write-Host -ForegroundColor Red "=========================================================="
	
	docker rm -fv $(docker ps -aq)

	Write-Host -ForegroundColor Red "=========================================================="
	Write-Host -ForegroundColor Red "Removing All Images"
	Write-Host -ForegroundColor Red "=========================================================="
	
	docker rmi -f $(docker images -qf dangling=true)
	docker rmi -f $(docker images -q)
	docker image prune -af

	Write-Host -ForegroundColor Red "=========================================================="
	Write-Host -ForegroundColor Red "Removing All Volumes"
	Write-Host -ForegroundColor Red "=========================================================="
	
	docker volume rm (docker volume ls -qf dangling=true)
	docker volume rm $(docker volume ls)
	docker volume prune -f

	Write-Host ""
} Else {
	Write-Host -ForegroundColor Red "=========================================================="
	Write-Host -ForegroundColor Red "Wrong Operation Received"
	Write-Host -ForegroundColor Red "Use: --view | --pd | --pu | --pc | --pa"
	Write-Host -ForegroundColor Red "=========================================================="
}
