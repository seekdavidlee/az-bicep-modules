# Introduction
In this project, we are focused on deploying a SQL Server with a database with Bicep. When creating the SQL server, we will need to provide an admin username and password. We will be storing the admin username and password in Azure Key Vault and using a reference to pass it onto the deployment via a Bicep module. We will also be creating two databases for the 2 apps that will be leveraging them.

![Architecture](/Architecture/Design.png)

# Steps
Before we start, please ensure you have an existing Azure Key Vault instance with two secrets configured for SQL admin username (contoso-sql-server-username) and password (contoso-sql-server-password). The reason why we don't include a Key Vault into our Bicep is because I subscribe to the idea of a Key Vault being a shared resource and is governed different. If you refer to the [governance example](https://github.com/seekdavidlee/eklee-governance), it would help. Make sure you have the right RBAC which is minimally a Azure Key Vault Secrets User. When you are done, you can use the bicep file to deploy. Let's launch CloudShell and clone this repo there.

1. Create resource group with the following command ``` az group create --name bicep-demo --location centralus ``` 
2. Configure your vairables ``` $stackName="<Unique name for the SQL Server>"; $keyVaultName="<Name of your Azure Key Vault>; $sharedResourceGroup="<Name of the resource group said Azure Key Vault is located in>" ```
3. Next, let's deploy this into the resource group ``` az deployment group create -n deploy-1 -g bicep-demo --template-file deploy.bicep --parameters stackName=$stackName keyVaultName=$keyVaultName sharedResourceGroup=$sharedResourceGroup ```
