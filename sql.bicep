param location string
param stackName string
param tags object
@secure()
param sqlUsername string
@secure()
param sqlPassword string

resource sql 'Microsoft.Sql/servers@2021-02-01-preview' = {
  name: stackName
  location: location
  tags: tags
  properties: {
    administratorLogin: sqlUsername
    administratorLoginPassword: sqlPassword
    version: '12.0'
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
  }
}

resource db1 'Microsoft.Sql/servers/databases@2021-02-01-preview' = {
  name: 'app1'
  parent: sql
  location: location
  tags: tags
  sku: {
    name: 'Basic'
    tier: 'Basic'
    capacity: 5
  }
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
  }
}

resource db2 'Microsoft.Sql/servers/databases@2021-02-01-preview' = {
  name: 'app2'
  parent: sql
  location: location
  tags: tags
  sku: {
    name: 'Basic'
    tier: 'Basic'
    capacity: 5
  }
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
  }
}

resource sqlfw 'Microsoft.Sql/servers/firewallRules@2021-02-01-preview' = {
  parent: sql
  name: 'AllowAllMicrosoftAzureIps'
  properties: {
    endIpAddress: '0.0.0.0'
    startIpAddress: '0.0.0.0'
  }
}

output sqlFqdn string = sql.properties.fullyQualifiedDomainName
