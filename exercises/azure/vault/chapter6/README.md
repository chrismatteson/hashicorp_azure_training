### Chapter 6 - Exercise 1 - Policies and Roles
* Create policy to allow read access to MySQL server creds path
* Create a role for Azure auth using the policy created in the prior task and bound to the subscription_id and resource_group. 
* Authenticate to Vault using the JWT token, verify access to the MySQL creds, and that there is not access to view th MySQL Secret Engine configuration.

https://www.vaultproject.io/docs/concepts/policies.html
https://www.vaultproject.io/docs/auth/azure.html  
