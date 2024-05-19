@minLength(3)
@maxLength(11)

param storageAccountPrefix string = 'ctt'
param AzureRegion string = resourceGroup().location

var sta = '${storageAccountPrefix}${uniqueString(subscription().id)}'

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: sta
  location: AzureRegion
  kind: 'StorageV2'
  sku: {
    name: 'Premium_LRS'
  }
}
