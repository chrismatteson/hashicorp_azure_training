## Chapter 6 Solutions

* Create policy
`vault policy write my-policy -<<EOF
path "database/creds/my-role" {
  capabilities = ["read"]
}
EOF`
`vault write auth/azure/role/azure-role \
  policies="my-policy" \
  bound_subscription_ids=8708baf2-0a54-4bb4-905b-78d21ac150da \
  bound_resource_groups=911dfe0a-rg`
`ssh ubuntu@52.170.197.72`
`export VAULT_ADDR=http://localhost:8200`
`vault write auth/azure/login role="azure-role" \
     jwt="$(curl -s 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fmanagement.azure.com' -H Metadata:true | jq -r '.access_token')" \
     subscription_id=$(curl -s -H Metadata:true "http://169.254.169.254/metadata/instance?api-version=2017-08-01" | jq -r '.compute | .subscriptionId')  \
     resource_group_name=$(curl -s -H Metadata:true "http://169.254.169.254/metadata/instance?api-version=2017-08-01" | jq -r '.compute | .resourceGroupName') \
     vm_name=$(curl -s -H Metadata:true "http://169.254.169.254/metadata/instance?api-version=2017-08-01" | jq -r '.compute | .name')`
`vault login s.Mqfez3JZhUPpK1x7UC8Ixelz`
`vault read database/creds/my-role`
`vault read database/config/exampledb` 

