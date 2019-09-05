output "public_ip_address" {
  depends_on = ["azurerm_public_ip.main"]
  value = ["${azurerm_public_ip.main.*.ip_address}"]
}

output "private_ip_address" {
  depends_on = ["azurerm_network_interface.main"]
  value = ["${azurerm_network_interface.main.*.private_ip_address}"]
}

output "public_dns_address" {
  depends_on = ["azurerm_public_ip.main"]
  value = ["${azurerm_public_ip.main.*.fqdn}"]
}