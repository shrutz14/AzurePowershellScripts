# Creating VM
$vmName="appvm"
$vmSize="Standard_DS2_v2"
$Location="North Europe"

$Credential=Get-Credential

$vmConfig=New-AzVMConfig -Name $vmName -VMSize $vmSize
Set-AzVMOperatingSystem -VM $vmConfig -ComputerName $vmName -Credential $Credential -Windows

Set-AzVMSourceImage -Vm $vmConfig -PublisherName "MicrosoftWindowsServer" -Offer "WindowsServer" -Skus "2023-Datacenter" -Version "latest"

$networkInterfaceName="app-interface"
$networkInterface=Get-AzNetworkInterface -Name $networkInterfaceName -ResourceGroupName $resourceGroup

$Vm=Add-AzNetworkInterface -VM $vmConfig -Id $networkInterface.Id

Set-AzVMBootDiagnostic -Disable -VM $Vm

New-AzVM -ResourceGroupName $resourceGroup -Location $Location -VM $Vm