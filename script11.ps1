#create and attach data disk to the VM created

$vmName="appvm"
$resourceGroup="app-grpShruti"
$diskName="app-disk"
#Get details of existing VM
$vm=Get-AzVM -ResourceGroupName $resourceGroup -Name $vmName
$vm | Add-AzVMDataDisk -Name $diskName -DiskSizeInGB 16 -CreateOption Empty -Lun 0

#to stamp the change onto azure to our vm
$vm | Update-AzVM