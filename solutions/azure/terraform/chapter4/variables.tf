# variables.tf – commonly configured parameters for our environment (i.e. projectName)

# Azure Location
variable "location" {
  default = "eastus"
}

# Azure Tags
variable "tags" {
  type    = "map"
  default = {}
}

# Vault Binary URL
variable vault_url {
  description = "URL to download Vault Enterprise"
  default     = "http://hc-enterprise-binaries.s3.amazonaws.com/vault/ent/1.1.1/vault-enterprise_1.1.1%2Bent_linux_amd64.zip"
}
