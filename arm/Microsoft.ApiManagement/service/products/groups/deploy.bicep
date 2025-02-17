@description('Required. The name of the of the Api Management service.')
param apiManagementServiceName string

@description('Required. The name of the of the Product.')
param productName string

@description('Optional. Customer Usage Attribution id (GUID). This GUID must be previously registered')
param cuaId string = ''

@description('Required. Name of the product group.')
param name string

module pid_cuaId '.bicep/nested_cuaId.bicep' = if (!empty(cuaId)) {
  name: 'pid-${cuaId}'
  params: {}
}

resource group 'Microsoft.ApiManagement/service/products/groups@2020-06-01-preview' = {
  name: '${apiManagementServiceName}/${productName}/${name}'
}

@description('The resourceId of the product group')
output groupResourceId string = group.id

@description('The name of the product group')
output groupName string = group.name

@description('The resource group the product group was deployed into')
output groupResourceGroup string = resourceGroup().name
