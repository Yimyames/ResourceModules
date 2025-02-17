@description('Required. The name of the EventHub namespace')
param namespaceName string

@description('Required. The name of the EventHub namespace eventHub')
param eventHubName string

@description('Required. The name of the consumer group')
param name string

@description('Optional. User Metadata is a placeholder to store user-defined string data with maximum length 1024. e.g. it can be used to store descriptive data, such as list of teams and their contact information also user-defined configuration settings can be stored.')
param userMetadata string = ''

@description('Optional. Customer Usage Attribution id (GUID). This GUID must be previously registered')
param cuaId string = ''

module pid_cuaId '.bicep/nested_cuaId.bicep' = if (!empty(cuaId)) {
  name: 'pid-${cuaId}'
  params: {}
}

resource consumerGroup 'Microsoft.EventHub/namespaces/eventhubs/consumergroups@2021-06-01-preview' = {
  name: '${namespaceName}/${eventHubName}/${name}'
  properties: {
    userMetadata: !empty(userMetadata) ? userMetadata : null
  }
}

@description('The name of the consumer group.')
output consumerGroupName string = consumerGroup.name

@description('The Resource Id of the consumer group.')
output consumerGroupResourceId string = consumerGroup.id

@description('The name of the Resource Group the consumer group was created in.')
output consumerGroupResourceGroup string = resourceGroup().name
