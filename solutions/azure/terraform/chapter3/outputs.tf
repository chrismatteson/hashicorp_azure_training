# output.tf - outputs important parameters will need to finish configuring vault
# These parameters will but spit out after each terraform apply

output "download_vault" {
  value       = "sudo wget ${var.vault_url} -P /usr/local/bin/vault; sudo chmod 755 /usr/local/bin/vault"
  description = "Command to download and install Vault binary"
}

