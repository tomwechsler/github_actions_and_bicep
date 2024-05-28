targetScope = 'subscription'

param azureRegion string = 'switzerlandnorth'
param resourceGroupName string = 'ctt-rg-${azureRegion}'
param projectNameTag string = 'Production'
param projectEnvTag string = 'DevOps'

resource cttresourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: azureRegion
  tags: {
    Project: projectNameTag
    Environment: projectEnvTag
  }
}

module appServices 'modules/web-app.bicep' = {
  scope: resourceGroup(cttresourceGroup.name)
  name: 'appDeployment-${uniqueString(cttresourceGroup.id)}'
  params: {
    azureRegion: azureRegion
    appServiceAppDevName: 'appDev${uniqueString(cttresourceGroup.id)}'
    appServiceAppTestName: 'appTest${uniqueString(cttresourceGroup.id)}'
    appServicePlanName: 'ctt-appServiceplan'
    projectNameTag: projectNameTag
    projectEnvTag: projectEnvTag
  }
}

module storageServices 'modules/storage.bicep' = {
  scope: resourceGroup(cttresourceGroup.name)
  name: 'stgDeployment-${uniqueString(cttresourceGroup.id)}'
  params: {
    azureRegion: azureRegion
    projectNameTag: projectNameTag
    projectEnvTag: projectEnvTag
  }
}

module networkServices 'modules/vnet.bicep' = {
  scope: resourceGroup(cttresourceGroup.name)
  name: 'vnetDeployment-${uniqueString(cttresourceGroup.id)}'
  params: {
    location: azureRegion
    prefix: 'ctt-devops'
  }

}
