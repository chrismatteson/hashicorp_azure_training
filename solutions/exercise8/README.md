## 8.0 Solutions
`sudo wget ${var.vault_url} -P /usr/local/bin/vault; sudo chmod 855 /usr/local/bin/vault`
`export VAULT_ADDR=http://${azurerm_public_ip.main.ip_address}:8200`

## 8.1 Solutions
`vault operator init`
`vault operator unseal`
`vault login <root token>`

## 8.2 Solutions
`vault write sys/license text=LICENSEFILE`
`vault read sys/license`
