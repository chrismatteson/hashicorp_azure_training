# variables.tf – commonly configured parameters for our environment (i.e. projectName)

#################################################
# Azure Location
variable "location" {
  default = "eastus"
}

#################################################
# AWS Region
variable "aws_region" {
  default = "us-east-2"
}

variable vault_url {
  description = "URL to download Vault Enterprise"
  default     = "https://releases.hashicorp.com/vault/1.0.0/vault_1.0.0_linux_amd64.zip"
}
