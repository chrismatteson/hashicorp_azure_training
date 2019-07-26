### Chapter 2 - Exercise 1 - Connect to and Deploy Vault
* Run commands from outputs to install and configure vault agent
* Initialize, Unseal, and Authenticate to Vault using the initial root token.
* View status of vault
* Lookup token information

https://learn.hashicorp.com/vault/getting-started/deploy  
https://www.vaultproject.io/docs/commands/status.html  
https://www.vaultproject.io/docs/commands/token/lookup.html  

`HINT 1: Vault CLI assumes Vault is installed on the localhost using TLS. Google VAULT_ADDR environment variable to see how to change that setting`

`HINT 2: Copy the unseal keys and initial root token somewhere incase you need to use them again`

`HINT 3: Vault Enterprise will shutdown after 30 minutes without a license file and error out during the unseal process. If this occurs to you, run "sudo service vault restart`

### Chapter 2 - Exercise 2 - Enterprise License
* Write the license file provided by the Trainer into /sys/license
* Verify that vault license is installed

https://www.vaultproject.io/api/system/license.html  
