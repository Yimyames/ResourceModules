@maxLength(24)
@description('Required. Name of the Storage Account.')
param storageAccountName string

@description('Optional. The name of the storage container to deploy')
param name string = 'default'

@description('Required. The Storage Account ManagementPolicies Rules')
param rules array

@description('Optional. Customer Usage Attribution id (GUID). This GUID must be previously registered')
param cuaId string = ''

module pid_cuaId '.bicep/nested_cuaId.bicep' = if (!empty(cuaId)) {
  name: 'pid-${cuaId}'
  params: {}
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-06-01' existing = {
  name: storageAccountName

  // lifecycle policy
  resource managementPolicy 'managementPolicies@2019-06-01' = if (!empty(rules)) {
    name: name
    properties: {
      policy: {
        rules: rules
      }
    }
  }
}

@description('The resource Id of the deployed management policy')
output managementPoliciesResourceId string = storageAccount::managementPolicy.name

@description('The name of the deployed management policy')
output managementPoliciesName string = storageAccount::managementPolicy.name

@description('The resource group of the deployed management policy')
output managementPoliciesResourceGroup string = resourceGroup().name
