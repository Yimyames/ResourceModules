# policySetDefinition `[Microsoft.Authorization/policySetDefinitions]`

## Resource types

| Resource Type | Api Version |
| :-- | :-- |
| `Microsoft.Authorization/policySetDefinitions` | 2020-09-01 |

## Parameters

| Parameter Name | Type | Default Value | Possible Values | Description |
| :-- | :-- | :-- | :-- | :-- |
| `displayName` | string |  |  | Optional. The display name of the Set Definition (Initiative) |
| `location` | string | `[deployment().location]` |  | Optional. Location for all resources. |
| `managementGroupId` | string |  |  | Optional. The ID of the Management Group (Scope). Cannot be used with subscriptionId and does not support tenant level deployment (i.e. '/') |
| `metadata` | object | `{object}` |  | Optional. The Set Definition (Initiative) metadata. Metadata is an open ended object and is typically a collection of key value pairs. |
| `parameters` | object | `{object}` |  | Optional. The Set Definition (Initiative) parameters that can be used in policy definition references. |
| `policyDefinitionGroups` | array | `[]` |  | Optional. The metadata describing groups of policy definition references within the Policy Set Definition (Initiative). |
| `policyDefinitions` | array |  |  | Required. The array of Policy definitions object to include for this policy set. Each object must include the Policy definition ID, and optionally other properties like parameters |
| `policySetDefinitionName` | string |  |  | Required. Specifies the name of the policy Set Definition (Initiative). Space characters will be replaced by (-) and converted to lowercase |
| `policySetDescription` | string |  |  | Optional. The Description name of the Set Definition (Initiative) |
| `subscriptionId` | string |  |  | Optional. The ID of the Azure Subscription (Scope). Cannot be used with managementGroupId |

### Parameter Usage: `managementGroupId`

To deploy resource to a Management Group, provide the `managementGroupId` as an input parameter to the module.

```json
"managementGroupId": {
    "value": "contoso-group"
}
```

> The name of the Management Group in the deployment does not have to match the value of the `managementGroupId` in the input parameters.

### Parameter Usage: `subscriptionId`

To deploy resource to an Azure Subscription, provide the `subscriptionId` as an input parameter to the module. **Example**:

```json
"subscriptionId": {
    "value": "12345678-b049-471c-95af-123456789012"
}
```

## Outputs

| Output Name | Type |
| :-- | :-- |
| `policySetDefinitionId` | string |
| `policySetDefinitionName` | string |

## Considerations

- Policy Set Definitions (Initiatives) have a dependency on Policy Assignments being applied before creating an initiative. You can use the Policy Assignment [Module](../policyDefinitions/deploy.bicep) to deploy a Policy Definition and then create an initiative for it on the required scope.

## Template references

- [Policysetdefinitions](https://docs.microsoft.com/en-us/azure/templates/Microsoft.Authorization/2020-09-01/policySetDefinitions)
