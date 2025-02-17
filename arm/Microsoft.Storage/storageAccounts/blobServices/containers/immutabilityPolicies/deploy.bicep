@maxLength(24)
@description('Required. Name of the Storage Account.')
param storageAccountName string

@description('Optional. Name of the blob service.')
param blobServicesName string = 'default'

@description('Required. Name of the container to apply the policy to')
param containerName string

@description('Optional. Name of the immutable policy.')
param name string = 'default'

@description('The immutability period for the blobs in the container since the policy creation, in days.')
param immutabilityPeriodSinceCreationInDays int = 365

@description('This property can only be changed for unlocked time-based retention policies. When enabled, new blocks can be written to an append blob while maintaining immutability protection and compliance. Only new blocks can be added and any existing blocks cannot be modified or deleted. This property cannot be changed with ExtendImmutabilityPolicy API')
param allowProtectedAppendWrites bool = true

@description('Optional. Customer Usage Attribution id (GUID). This GUID must be previously registered')
param cuaId string = ''

module pid_cuaId '.bicep/nested_cuaId.bicep' = if (!empty(cuaId)) {
  name: 'pid-${cuaId}'
  params: {}
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-06-01' existing = {
  name: storageAccountName

  resource blobServices 'blobServices@2021-06-01' existing = {
    name: blobServicesName

    resource container 'containers@2019-06-01' existing = {
      name: containerName

      resource immutabilityPolicy 'immutabilityPolicies@2019-06-01' = {
        name: name
        properties: {
          immutabilityPeriodSinceCreationInDays: immutabilityPeriodSinceCreationInDays
          allowProtectedAppendWrites: allowProtectedAppendWrites
        }
      }
    }
  }
}

@description('The name of the deployed immutability policy.')
output immutabilityPolicyName string = storageAccount::blobServices::container::immutabilityPolicy.name

@description('The id of the deployed immutability policy.')
output immutabilityPolicyResourceId string = storageAccount::blobServices::container::immutabilityPolicy.id

@description('The resource group of the deployed immutability policy.')
output immutabilityPolicyResourceGroup string = resourceGroup().name
