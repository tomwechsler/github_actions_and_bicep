#Install the Azure PowerShell Module
Install-Module -Name Az -AllowClobber -Verbose -Force

#Connect to Azure
Connect-AzAccount

#Create a new resource group
New-AzResourceGroup -Name "gha-bicep-rg" -location "switzerlandnorth"

#Deploy the bicep file
New-AzResourceGroupDeployment -name "bicep" -ResourceGroupName gha-bicep-rg -TemplateFile 04_The_first_samples\storage.bicep