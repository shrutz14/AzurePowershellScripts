# Creating a publc Ip Address which is a stand alone resource and it does not require any prior objects
$resourceGroup="app-grpShruti"
$location="North Europe"
$publicIPAddress="app-ip"

New-AzPublicIpAddress -Name $publicIPAddress -ResourceGroupName $resourceGroup
-Location $location -AllocationMethod Dynamic