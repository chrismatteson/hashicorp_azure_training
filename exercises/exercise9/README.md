## 9.0 HashiCorp Vault - Dynamic Secrets
Setup Dynamic Secrets

### 9.0 Tasks
* Enable Vault Database Secret Engine and configure it to connect to sql_server created in a prior task.
* Read the creds path and show that dynamic secrets are generated each time.

https://www.vaultproject.io/docs/secrets/databases/mssql.html

## 9.1 HashiCorp Vault - Leases
Review and Revoke leases

### 9.1 Tasks
* View the leases from the creds generated in the prior step.
* Revoke a single lease, show that it's been revoked.
* Revoke all the leases, show that they have all been revoked.

* https://www.vaultproject.io/docs/concepts/lease.html

## 9.2 HashiCorp Vault - Transit Engine
Setup Transit Engine

### 9.2 Tasks
