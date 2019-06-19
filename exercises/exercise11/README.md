## 11.0 HashiCorp Vault - Policies
Create policies to limit access to MySQL creds

### 11.0 Tasks
* Create policy to allow read access to MySQL server creds path

https://www.vaultproject.io/docs/concepts/policies.html  

## 11.0 HashiCorp Vault - Roles
Create Azure Auth Role and access secrets using JWT token

### 11.1 Tasks
* Create a role for Azure auth using the policy created in the prior task and bound to the subscription_id and resource_group. 
* Authenticate to Vault using the JWT token, verify access to the MySQL creds, and that there is not access to view th MySQL Secret Engine configuration.

https://www.vaultproject.io/docs/auth/azure.html  
