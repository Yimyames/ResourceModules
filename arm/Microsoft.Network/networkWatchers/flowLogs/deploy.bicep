@description('Optional. Name of the network watcher resource. Must be in the resource group where the Flow log will be created and same region as the NSG')
param networkWatcherName string = 'NetworkWatcher_${resourceGroup().location}'

@description('Optional. Name of the resource.')
param name string = '${last(split(targetResourceId, '/'))}-${split(targetResourceId, '/')[4]}-flowlog'

@description('Optional. Tags of the resource.')
param tags object = {}

@description('Optional. Location for all resources.')
param location string = resourceGroup().location

@description('Required. Resource ID of the NSG that must be enabled for Flow Logs.')
param targetResourceId string

@description('Required. Resource identifier of the Diagnostic Storage Account.')
param storageId string

@description('Optional. If the flow log should be enabled')
param enabled bool = true

@description('Optional. The flow log format version')
@allowed([
  1
  2
])
param formatVersion int = 2

@description('Optional. Specify the Log Analytics Workspace Resource ID')
param workspaceResourceId string = ''

@description('Optional. The interval in minutes which would decide how frequently TA service should do flow analytics.')
@allowed([
  10
  60
])
param trafficAnalyticsInterval int = 60

@description('Optional. Specifies the number of days that logs will be kept for; a value of 0 will retain data indefinitely.')
@minValue(0)
@maxValue(365)
param retentionInDays int = 365

@description('Optional. Customer Usage Attribution id (GUID). This GUID must be previously registered')
param cuaId string = ''

var flowAnalyticsConfiguration = !empty(workspaceResourceId) && enabled == true ? {
  networkWatcherFlowAnalyticsConfiguration: {
    enabled: true
    workspaceResourceId: workspaceResourceId
    trafficAnalyticsInterval: trafficAnalyticsInterval
  }
} : {
  networkWatcherFlowAnalyticsConfiguration: {
    enabled: false
  }
}

module pid_cuaId '.bicep/nested_cuaId.bicep' = if (!empty(cuaId)) {
  name: 'pid-${cuaId}'
  params: {}
}

resource flowLog 'Microsoft.Network/networkWatchers/flowLogs@2021-03-01' = {
  name: '${networkWatcherName}/${name}'
  tags: tags
  location: location
  properties: {
    targetResourceId: targetResourceId
    storageId: storageId
    enabled: enabled
    retentionPolicy: {
      days: retentionInDays
      enabled: retentionInDays == 0 ? false : true
    }
    format: {
      type: 'JSON'
      version: formatVersion
    }
    flowAnalyticsConfiguration: flowAnalyticsConfiguration
  }
}
@description('The name of the flow log')
output flowLogName string = flowLog.name

@description('The resourceId of the flow log')
output flowLogResourceId string = flowLog.id

@description('The resource group the flow log was deployed into')
output flowLogResourceGroup string = resourceGroup().name
