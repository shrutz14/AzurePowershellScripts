#Creating a storage account

$resourceGroup="app-grpShruti"
$location="North Europe"
$accountSKU="Standard_LRS"
$storageAccountName="appStore4443434"
$storageAccountKind="StorageV2"

New-AzStorageAccount -ResourceGroupName $resourceGroup -Location $location -Kind $storageAccountKind -SkuName $accountSKU -Name $storageAccountName
