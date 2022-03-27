param stackName string
param keyVaultName string
param sharedResourceGroup string
param location string = 'centralus'

var tags = {
  'stack-name': 'contoso-shared-sql'
  'stack-owner': 'team1@contoso.com'
}

resource kv 'Microsoft.KeyVault/vaults@2019-09-01' existing = {
  name: keyVaultName
  scope: resourceGroup(subscription().subscriptionId, sharedResourceGroup)
}

module sql './sql.bicep' = {
  name: 'deploySQL'
  params: {
    stackName: stackName
    sqlUsername: kv.getSecret('contoso-sql-server-username')
    sqlPassword: kv.getSecret('contoso-sql-server-password')
    tags: tags
    location: location
  }
}
