# EventHub Namespace EventHubs Consumer Group `[Microsoft.EventHub/namespaces/eventhubs/consumergroups]`

This module deploys an EventHub Namespace EventHubs Consumer Group

## Resource Types

| Resource Type | Api Version |
| :-- | :-- |
| `Microsoft.EventHub/namespaces/eventhubs/consumergroups` | 2021-06-01-preview |

## Parameters

| Parameter Name | Type | Default Value | Possible Values | Description |
| :-- | :-- | :-- | :-- | :-- |
| `cuaId` | string |  |  | Optional. Customer Usage Attribution id (GUID). This GUID must be previously registered |
| `eventHubName` | string |  |  | Required. The name of the EventHub namespace eventHub |
| `name` | string |  |  | Required. The name of the consumer group |
| `namespaceName` | string |  |  | Required. The name of the EventHub namespace |
| `userMetadata` | string |  |  | Optional. User Metadata is a placeholder to store user-defined string data with maximum length 1024. e.g. it can be used to store descriptive data, such as list of teams and their contact information also user-defined configuration settings can be stored. |

## Outputs

| Output Name | Type | Description |
| :-- | :-- | :-- |
| `consumerGroupName` | string | The name of the consumer group. |
| `consumerGroupResourceGroup` | string | The name of the Resource Group the consumer group was created in. |
| `consumerGroupResourceId` | string | The Resource Id of the consumer group. |

## Template references

- [Namespaces/Eventhubs/Consumergroups](https://docs.microsoft.com/en-us/azure/templates/Microsoft.EventHub/2021-06-01-preview/namespaces/eventhubs/consumergroups)
