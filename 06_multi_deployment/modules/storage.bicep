@description('The Azure region for the deployment')
param azureRegion string = resourceGroup().location

@minLength(3)
@maxLength(32)
param accountNamePrefix string = 'uniqueString(resourceGroup().id)'

param projectNameTag string
param projectEnvTag string

param storageConfig object = {
  marketing: {
    name: '${accountNamePrefix}mkt'
    skuName: 'Standard_LRS'
  }
  accounting: {
    name: '${accountNamePrefix}acc'
    skuName: 'Premium_LRS'
  }
  itoperations: {
    name: '${accountNamePrefix}itops'
    skuName: 'Premium_LRS'
  }
}

resource createStorages 'Microsoft.Storage/storageAccounts@2021-02-01' = [for config in items(storageConfig): {
  name: '${config.value.name}'
  location: azureRegion
  sku: {
    name: config.value.skuName
  }
  kind: 'StorageV2'
  tags: {
    Project: projectNameTag
    Environment: projectEnvTag
  }
}]
