#Entire setup in one script
$resourceGroup="app-grpShruti"
$networkName="app-network"
$location="North Europe"
$AddressPrefix="10.0.0.0/16"
$subnetName="SubnetA"
$subnetAddressPrefix="10.0.0.0/24"

$subnet= New-AzureRmVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix $subnetAddressPrefix 

New-AzVirtualNetwork -Name $networkName -ResourceGroupName $resourceGroup
-Location $location -AddressPrefix $AddressPrefix -Subnet $subnet

$publicIPAddress="app-ip"

$PublicIpAddressNew=New-AzPublicIpAddress -Name $publicIPAddress -ResourceGroupName $resourceGroup
-Location $location -AllocationMethod Dynamic
$networkInterfaceName="app-interface"

$VirtualNetwork=Get-AzVirtualNetwork -Name $networkName -ResourceGroupName $resourceGroup

$subnet= Get-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $VirtualNetwork -Name $subnetName

$NetworkInterfaceNew=New-AzNetworkInterface -Name $networkInterfaceName -ResourceGroupName $resourceGroup -Location $location
-subnetId $subnet.Id -IpConfigurationName "IpConfig"

#Attach the public IP Address to the network interface

$IpConfig=Get-AzNetworkInterfaceIpConfig -NetworkInterface $NetworkInterface
$NetworkInterfaceNew | Set-AzNetworkInterfaceIpConfig -PublicIpAddress $PublicIpAddressNew -Name $IpConfig.Name
$NetworkInterfaceNew | Set-AzNetworkInterface

$networkSecurityGroupName="app-nsg"

$nsgRule1=New-AzNetworkSecurityRuleConfig -Name "Allow-RDP" -Access Allow -Protocol Tcp -Direction Inbound -Priority 120 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix 10.0.0.0/24 -DestinationPortRange 3389

$nsgRule2=New-AzNetworkSecurityRuleConfig -Name "Allow-HTTP" -Access Allow -Protocol Tcp -Direction Inbound -Priority 130 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix 10.0.0.0/24 -DestinationPortRange 80

$networkSecurityGroup=New-AzNetworkSecurityGroup -Name $networkSecurityGroupName -ResourceGroupName $resourceGroup -Location $location -SecurityRules $nsgRule1,$nsgRule2

#Attach the NSG to the subnet

Set-AzVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork $VirtualNetwork -NetworkSecurityGroup $networkSecurityGroup -AddressPrefix $subnetAddressPrefix

$VirtualNetwork | Set-AzVirtualNetwork

$vmName="appvm"
$vmSize="Standard_DS2_v2"
$Credential=Get-Credential

$vmConfig=New-AzVMConfig -Name $vmName -VMSize $vmSize
Set-AzVMOperatingSystem -VM $vmConfig -ComputerName $vmName -Credential $Credential -Windows

Set-AzVMSourceImage -Vm $vmConfig -PublisherName "MicrosoftWindowsServer" -Offer "WindowsServer" -Skus "2023-Datacenter" -Version "latest"

$networkInterfaceName="app-interface"
$networkInterface=Get-AzNetworkInterface -Name $networkInterfaceName -ResourceGroupName $resourceGroup

$Vm=Add-AzNetworkInterface -VM $vmConfig -Id $networkInterface.Id

Set-AzVMBootDiagnostic -Disable -VM $Vm

New-AzVM -ResourceGroupName $resourceGroup -Location $Location -VM $Vm
