
$resourceGroup="app-grpShruti"
$location="North Europe"
$networkName="app-network"
$AddressPrefix="10.0.0.0/16"

# Remove-AzVirtualNetwork -Name $networkName -ResourceGroupName $resourceGroup

$VirtualNetwork=New-AzVirtualNetwork -Name $networkName -ResourceGroupName $resourceGroup
-Location $location -AddressPrefix $AddressPrefix
Write-Host $VirtualNetwork.AddressSpace.AddressPrefixes
Write-Host $VirtualNetwork.Location