@description('The Region for the deployment')
param azureRegion string = resourceGroup().location

param appServiceAppDevName string
param appServiceAppTestName string

param appServicePlanName string

param projectNameTag string
param projectEnvTag string

resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: appServicePlanName
  location: azureRegion
  sku: {
    name: 'F1'
    tier: 'free'
  }
  tags: {
    Project: projectNameTag
    Environment: projectEnvTag
  }
}

resource appServiceAppDev 'Microsoft.Web/sites@2021-01-15' = {
  name: appServiceAppDevName
  location: azureRegion
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
  tags: {
    Project: projectNameTag
    Environment: projectEnvTag
  }
}

resource appServiceAppTest 'Microsoft.Web/sites@2021-01-15' = {
  name: appServiceAppTestName
  location: azureRegion
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
  tags: {
    Project: projectNameTag
    Environment: projectEnvTag
  }
}

output webAppHostDev string = appServiceAppDev.properties.defaultHostName

output webAppHostTest string = appServiceAppTest.properties.defaultHostName
