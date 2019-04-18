## 9.0 Solutions
`vault secrets enable database`
`vault write database/config/exampledb \
    plugin_name=mysql-database-plugin \
    allowed_roles="my-role" \
    connection_url="{{username}}:{{password}}@tcp(911dfe0a-mysql.database.windows.net:3306)/" \
    username="sqladmin@911dfe0a-mysql" \
    password="gcUXCPaUhoqNr277W6YXgwIjQjhKb95FVAQDSiD4UHE"`
`vault write database/roles/my-role \
    db_name=exampledb \
    creation_statements="CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT SELECT ON *.* TO '{{name}}'@'%';" \ 
    default_ttl="1h" \
    max_ttl="24h"`

## 9.1 Solutions
`vault read database/leases
`vault revoke
`vault revoke

## 9.2 Solutions
`vault secrets enable transit`
`vault write -f transit/keys/my-key`
`vault write transit/encrypt/my-key plaintext=$(base64 <<< "my secret data")`
`vault write transit/decrypt/my-key ciphertext=vault:v1:8SDd3WHDOjf7mq69CyCqYjBXAiQQAVZRkFM13ok481zoCmHnSeDX9vyf7w==`base64 --decode <<< "bXkgc2VjcmV0IGRhdGEK"`
