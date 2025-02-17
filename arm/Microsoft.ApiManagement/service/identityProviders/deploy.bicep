@description('Required. The name of the of the Api Management service.')
param apiManagementServiceName string

@description('Optional. Customer Usage Attribution id (GUID). This GUID must be previously registered')
param cuaId string = ''

@description('Optional. Used to enable the deployment of the identityProviders child resource.')
param enableIdentityProviders bool = false

@description('Optional. List of Allowed Tenants when configuring Azure Active Directory login. - string')
param identityProviderAllowedTenants array = []

@description('Optional. OpenID Connect discovery endpoint hostname for AAD or AAD B2C.')
param identityProviderAuthority string = ''

@description('Optional. Client Id of the Application in the external Identity Provider. Required if identity provider is used.')
param identityProviderClientId string = ''

@description('Optional. Client secret of the Application in external Identity Provider, used to authenticate login request. Required if identity provider is used.')
@secure()
param identityProviderClientSecret string = ''

@description('Optional. Password Reset Policy Name. Only applies to AAD B2C Identity Provider.')
param identityProviderPasswordResetPolicyName string = ''

@description('Optional. Profile Editing Policy Name. Only applies to AAD B2C Identity Provider.')
param identityProviderProfileEditingPolicyName string = ''

@description('Optional. Signin Policy Name. Only applies to AAD B2C Identity Provider.')
param identityProviderSignInPolicyName string = ''

@description('Optional. The TenantId to use instead of Common when logging into Active Directory')
param identityProviderSignInTenant string = ''

@description('Optional. Signup Policy Name. Only applies to AAD B2C Identity Provider.')
param identityProviderSignUpPolicyName string = ''

@description('Optional. Identity Provider Type identifier.')
@allowed([
  'aad'
  'aadB2C'
  'facebook'
  'google'
  'microsoft'
  'twitter'
])
param identityProviderType string = 'aad'

@description('Required. Identity provider name')
param name string

var isAadB2C = (identityProviderType == 'aadB2C')

module pid_cuaId '.bicep/nested_cuaId.bicep' = if (!empty(cuaId)) {
  name: 'pid-${cuaId}'
  params: {}
}

resource identityProvider 'Microsoft.ApiManagement/service/identityProviders@2020-06-01-preview' = if (enableIdentityProviders) {
  name: '${apiManagementServiceName}/${name}'
  properties: {
    type: identityProviderType
    signinTenant: identityProviderSignInTenant
    allowedTenants: identityProviderAllowedTenants
    authority: identityProviderAuthority
    signupPolicyName: isAadB2C ? identityProviderSignUpPolicyName : null
    signinPolicyName: isAadB2C ? identityProviderSignInPolicyName : null
    profileEditingPolicyName: isAadB2C ? identityProviderProfileEditingPolicyName : null
    passwordResetPolicyName: isAadB2C ? identityProviderPasswordResetPolicyName : null
    clientId: identityProviderClientId
    clientSecret: identityProviderClientSecret
  }
}

@description('The resourceId of the API management service identity provider')
output identityProviderResourceId string = identityProvider.id

@description('The name of the API management service identity provider')
output identityProviderName string = identityProvider.name

@description('The resource group the API management service identity provider was deployed into')
output identityProviderResourceGroup string = resourceGroup().name
