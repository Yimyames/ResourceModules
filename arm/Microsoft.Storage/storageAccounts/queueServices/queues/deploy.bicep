@maxLength(24)
@description('Required. Name of the Storage Account.')
param storageAccountName string

@description('Optional. The name of the queue service')
param queueServicesName string = 'default'

@description('The name of the storage queue to deploy')
param name string

@description('A name-value pair that represents queue metadata.')
param metadata object = {}

@description('Optional. Array of role assignment objects that contain the \'roleDefinitionIdOrName\' and \'principalId\' to define RBAC role assignments on this resource. In the roleDefinitionIdOrName attribute, you can provide either the display name of the role definition, or it\'s fully qualified ID in the following format: \'/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11\'')
param roleAssignments array = []

@description('Optional. Customer Usage Attribution id (GUID). This GUID must be previously registered')
param cuaId string = ''

module pid_cuaId '.bicep/nested_cuaId.bicep' = if (!empty(cuaId)) {
  name: 'pid-${cuaId}'
  params: {}
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-06-01' existing = {
  name: storageAccountName

  resource queueServices 'queueServices@2021-06-01' existing = {
    name: queueServicesName

    resource queue 'queues@2019-06-01' = {
      name: name
      properties: {
        metadata: metadata
      }
    }
  }
}

module queue_rbac '.bicep/nested_rbac.bicep' = [for (roleAssignment, index) in roleAssignments: {
  name: '${deployment().name}-Rbac-${index}'
  params: {
    principalIds: roleAssignment.principalIds
    roleDefinitionIdOrName: roleAssignment.roleDefinitionIdOrName
    resourceName: '${storageAccount.name}/${storageAccount::queueServices.name}/${storageAccount::queueServices::queue.name}'
  }
}]

@description('The name of the deployed queue')
output queueName string = storageAccount::queueServices::queue.name

@description('The ID of the deployed queue')
output queueResourceId string = storageAccount::queueServices::queue.id

@description('The resource group of the deployed queue')
output queueResourceGroup string = resourceGroup().name
