output "network_interface" {
  value       = azurerm_network_interface.main.id
  description = "Network Interface ID"
}
output "public_ip" {
  value       = azurerm_public_ip.main.ip_address
  description = "Public IP"
}
