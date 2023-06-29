# Creating Internet interface
$resourceGroup="app-grpShruti"
$networkName="app-network"
$subnetName="SubnetA"
$networkInterfaceName="app-interface"

$VirtualNetwork=Get-AzVirtualNetwork -Name $networkName -ResourceGroupName $resourceGroup

$subnet= Get-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $VirtualNetwork -Name $subnetName

New-AzNetworkInterface -Name $networkInterfaceName -ResourceGroupName $resourceGroup -Location $location
-subnetId $subnet.Id -IpConfigurationName "IpConfig"