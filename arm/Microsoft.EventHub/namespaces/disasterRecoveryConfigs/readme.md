# EventHub Namespace Disaster Recovery Config `[Microsoft.EventHub/namespaces/disasterRecoveryConfigs]`

This module deploys an EventHub Namespace Disaster Recovery Config

## Resource Types

| Resource Type | Api Version |
| :-- | :-- |
| `Microsoft.EventHub/namespaces/disasterRecoveryConfigs` | 2017-04-01 |

## Parameters

| Parameter Name | Type | Default Value | Possible Values | Description |
| :-- | :-- | :-- | :-- | :-- |
| `cuaId` | string |  |  | Optional. Customer Usage Attribution id (GUID). This GUID must be previously registered |
| `name` | string |  |  | Required. The name of the disaster recovery config |
| `namespaceName` | string |  |  | Required. The name of the EventHub namespace |
| `partnerNamespaceId` | string |  |  | Optional. ARM Id of the Primary/Secondary eventhub namespace name, which is part of GEO DR pairing |

## Outputs

| Output Name | Type | Description |
| :-- | :-- | :-- |
| `disasterRecoveryConfigName` | string | The name of the disaster recovery config. |
| `disasterRecoveryConfigResourceGroup` | string | The name of the Resource Group the disaster recovery config was created in. |
| `disasterRecoveryConfigResourceId` | string | The Resource Id of the disaster recovery config. |

## Template references

- [Namespaces/Disasterrecoveryconfigs](https://docs.microsoft.com/en-us/azure/templates/Microsoft.EventHub/2017-04-01/namespaces/disasterRecoveryConfigs)
