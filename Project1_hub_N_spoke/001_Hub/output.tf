output "hub_vnet_id" {
  value = azurerm_virtual_network.hub-vnet.id
}

output "hub_vnet_name" {
  value = azurerm_virtual_network.hub-vnet.name
}

output "hub_rg_name" {
  value = azurerm_resource_group.hub_rg.name
}

output "firewall_private_ip" {
  value = azurerm_firewall.Hub_fw.ip_configuration[0].private_ip_address
}
output "Firewall_pip_id" {
  value = azurerm_public_ip.Firewall_pip.id
}