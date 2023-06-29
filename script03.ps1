$resourceGroup="app-grpShruti"
$networkName="app-network"

$VirtualNetwork=Get-AzVirtualNetwork -Name $networkName -ResourceGroupName $resourceGroup
Write-Host $VirtualNetwork.AddressSpace.AddressPrefixes
Write-Host $VirtualNetwork.Location