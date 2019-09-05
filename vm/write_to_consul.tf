resource "consul_keys" "app" {
  datacenter = "${local.datacenter}"

  key {
    path  = "${local.path_to_generated_azure_properties}/${local.project}/public_ip_address"
    value = "${join(",", azurerm_public_ip.main.*.ip_address)}"
  }

  key {
    path  = "${local.path_to_generated_azure_properties}/${local.project}/private_ip_address"
    value = "${join(",", azurerm_network_interface.main.*.private_ip_address)}"
  }

  key {
    path  = "${local.path_to_generated_azure_properties}/${local.project}/public_dns_address"
    value = "${join(",", azurerm_public_ip.main.*.fqdn)}"
  }
}