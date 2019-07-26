### Chapter 2 - Solutions

* Connect to Vault
`sudo wget ${var.vault_url} -P /usr/local/bin/vault; sudo chmod 855 /usr/local/bin/vault`
`export VAULT_ADDR=http://${azurerm_public_ip.main.ip_address}:8200`

* Init and unseal vault
`vault operator init`
`vault operator unseal`
`vault login <root token>`

* Install license file
`vault write sys/license text=LICENSEFILE`
`vault read sys/license`
