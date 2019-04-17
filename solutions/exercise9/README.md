## 9.0 Solutions
`vault secrets enable database`
`vault write database/config/my-mssql-database \
    plugin_name=mssql-database-plugin \
    connection_url='sqlserver://{{username}}:{{password}}@911dfe0a-sql.database.windows.net:1433' \
    allowed_roles="my-role" \
    username="sqladmin" \
    password="gcUXCPaUhoqNr277W6YXgwIjQjhKb95FVAQDSiD4UHE"`
`vault write database/roles/my-role \
    db_name=my-mssql-database \
    creation_statements="CREATE LOGIN [{{name}}] WITH PASSWORD = '{{password}}';\
        CREATE USER [{{name}}] FOR LOGIN [{{name}}];\
        GRANT SELECT ON SCHEMA::dbo TO [{{name}}];" \
    default_ttl="1h" \
    max_ttl="24h"`

## 9.1 Solutions
`
