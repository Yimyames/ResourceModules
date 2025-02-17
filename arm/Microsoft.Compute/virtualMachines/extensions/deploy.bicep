@description('Required. The name of the virtual machine that extension is provisioned for')
param virtualMachineName string

@description('Required. The name of the virtual machine extension')
param name string

@description('Optional. The location the extension is deployed to')
param location string = resourceGroup().location

@description('Required. The name of the extension handler publisher')
param publisher string

@description('Required. Specifies the type of the extension; an example is "CustomScriptExtension"')
param type string

@description('Required. Specifies the version of the script handler')
param typeHandlerVersion string

@description('Required. Indicates whether the extension should use a newer minor version if one is available at deployment time. Once deployed, however, the extension will not upgrade minor versions unless redeployed, even with this property set to true')
param autoUpgradeMinorVersion bool

@description('Optional. How the extension handler should be forced to update even if the extension configuration has not changed')
param forceUpdateTag string = ''

@description('Optional. Any object that contains the extension specific settings')
param settings object = {}

@description('Optional. Any object that contains the extension specific protected settings')
@secure()
param protectedSettings object = {}

@description('Optional. Indicates whether failures stemming from the extension will be suppressed (Operational failures such as not connecting to the VM will not be suppressed regardless of this value). The default is false')
param supressFailures bool = false

@description('Required. Indicates whether the extension should be automatically upgraded by the platform if there is a newer version of the extension available')
param enableAutomaticUpgrade bool

@description('Optional. Customer Usage Attribution id (GUID). This GUID must be previously registered')
param cuaId string = ''

module pid_cuaId '.bicep/nested_cuaId.bicep' = if (!empty(cuaId)) {
  name: 'pid-${cuaId}'
  params: {}
}

resource extension 'Microsoft.Compute/virtualMachines/extensions@2021-07-01' = {
  name: '${virtualMachineName}/${name}'
  location: location
  properties: {
    publisher: publisher
    type: type
    typeHandlerVersion: typeHandlerVersion
    autoUpgradeMinorVersion: autoUpgradeMinorVersion
    enableAutomaticUpgrade: enableAutomaticUpgrade
    forceUpdateTag: !empty(forceUpdateTag) ? forceUpdateTag : null
    settings: !empty(settings) ? settings : null
    protectedSettings: !empty(protectedSettings) ? protectedSettings : null
    suppressFailures: supressFailures
  }
}

@description('The name of the extension')
output extensionName string = extension.name

@description('The ResourceId of the extension')
output extensionId string = extension.id

@description('The name of the Resource Group the extension was created in.')
output extensionResourceGroup string = resourceGroup().name
