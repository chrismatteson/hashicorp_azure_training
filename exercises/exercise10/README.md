## 10.0 HashiCorp Vault - Dynamic Secrets
Setup Dynamic Secrets

### 10.0 Tasks
* Enable Vault Database Secret Engine and configure it to connect to mysql_database created in a prior exercise.
* Read the creds path and show that dynamic secrets are generated each time.

https://www.vaultproject.io/docs/secrets/databases/mysql.html  

## 10.1 HashiCorp Vault - Leases
Review and Revoke leases

### 10.1 Tasks
* View the leases from the creds generated in the prior step.
* Revoke a single lease, show that it's been revoked.
* Revoke all the leases, show that they have all been revoked.

https://www.vaultproject.io/docs/concepts/lease.html  
https://www.vaultproject.io/api/system/leases.html  

## 10.2 HashiCorp Vault - Transit Engine
Setup Transit Engine

### 10.2 Tasks
* Enable Transit Secrets Engine
* Create a key
* Encrypt and Decrypt a string

https://www.vaultproject.io/docs/secrets/transit/index.html  
