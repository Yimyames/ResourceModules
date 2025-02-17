@description('Required. The name of the of the Api Management service.')
param apiManagementServiceName string

@description('Optional. Customer Usage Attribution id (GUID). This GUID must be previously registered')
param cuaId string = ''

@description('Optional. API Version set name')
param name string = 'default'

@description('Optional. API Version set properties')
param properties object = {}

module pid_cuaId '.bicep/nested_cuaId.bicep' = if (!empty(cuaId)) {
  name: 'pid-${cuaId}'
  params: {}
}

resource apiVersionSet 'Microsoft.ApiManagement/service/apiVersionSets@2020-06-01-preview' = {
  name: '${apiManagementServiceName}/${name}'
  properties: properties
}

@description('The resourceId of the API Version set')
output apiVersionSetResourceId string = apiVersionSet.id

@description('The name of the API Version set')
output apiVersionSetName string = apiVersionSet.name

@description('The resource group the API Version set was deployed into')
output apiVersionSetResourceGroup string = resourceGroup().name
