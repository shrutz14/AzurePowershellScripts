#creating Azure web app

$resourceGroup="app-grpShruti"
$location="North Europe"
$appServiceName="demoplan55534"
$webAppName="webapp55434434"

#create an app service plan

New-AzAppServicePlan -ResourceGroupName $resourceGroup -Location $location -Name $appServiceName -Tier Free

New-AzWebApp -ResourceGroupName $resourceGroup -Name $webAppName -Location $location -AppServicePlan $appServiceName
