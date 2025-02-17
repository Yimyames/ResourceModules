# API Management Service Products Groups `[Microsoft.ApiManagement/service/products/groups]`

This module deploys Api Management Service Product Groups.

## Resource Types

| Resource Type | Api Version |
| :-- | :-- |
| `Microsoft.ApiManagement/service/products/groups` | 2020-06-01-preview |

## Parameters

| Parameter Name | Type | Default Value | Possible Values | Description |
| :-- | :-- | :-- | :-- | :-- |
| `apiManagementServiceName` | string |  |  | Required. The name of the of the Api Management service. |
| `cuaId` | string |  |  | Optional. Customer Usage Attribution id (GUID). This GUID must be previously registered |
| `name` | string |  |  | Required. Name of the product group. |
| `productName` | string |  |  | Required. The name of the of the Product. |

## Outputs

| Output Name | Type | Description |
| :-- | :-- | :-- |
| `groupName` | string | The name of the product group |
| `groupResourceGroup` | string | The resource group the product group was deployed into |
| `groupResourceId` | string | The resourceId of the product group |

## Template references

- [Service/Products/Groups](https://docs.microsoft.com/en-us/azure/templates/Microsoft.ApiManagement/2020-06-01-preview/service/products/groups)
