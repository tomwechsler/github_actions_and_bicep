@description('The Azure region for the deployment')
param azureRegion string = resourceGroup().location

@minLength(3)
@maxLength(11)
param accountNamePrefix string = 'ctt001'

param projectNameTag string
param projectEnvTag string

param storageConfig object = {
  marketing: {
    name: '${accountNamePrefix}marketing'
    skuName: 'Standard_LRS'
  }
  accounting: {
    name: '${accountNamePrefix}accounting'
    skuName: 'Premium_LRS'
  }
  itoperations: {
    name: '${accountNamePrefix}itoperations'
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
