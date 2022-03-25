# Introduction
In this project, we are focused on deploying a SQL Server with a database with Bicep. When creating the SQL server, we will need to provide an admin username and password. We will be storing the admin username and password in Azure Key Vault and using a reference to pass it onto the deployment via a Bicep module. We will also be creating two databases for the 2 apps that will be leveraging them.

![Architecture](/Architecture/Design.png)

# Steps
We have created a bicep file and we are ready to deploy. Let's launch CloudShell and clone this repo there.

1. Create resource group with the following command ``` az group create --name bicep-demo --location centralus ``` 
2. Create an Azure Key Vault and enable it with RBAC and template deployment. The reason why we don't include a Key Vault into our Bicep is because I subscribe to the idea of a Key Vault in our context being a shared resource and is governed different. The other implication is we need to already have configure our username and password in Azure Key Vault so this needs to be there already.
2. Configure your vairables ``` $stackName="<Unique name for the SQL Server>"; $keyVaultName="<Name of your Azure Key Vault>; $sharedResourceGroup="<Name of the resource group said Azure Key Vault is located in>" ```
3. Next, let's deploy this into the resource group ``` az deployment group create -n deploy-1 -g bicep-demo --template-file deploy.bicep --parameters stackName=$stackName keyVaultName=$keyVaultName sharedResourceGroup=$sharedResourceGroup ```
