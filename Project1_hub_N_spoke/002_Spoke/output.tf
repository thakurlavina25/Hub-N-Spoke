output "spoke_vnet_id" {
  value = {
    for k, v in azurerm_virtual_network.Spoke-vnet : k => v.id
  }
}

output "spoke_vnet_names" {
  value = {
    for k, v in azurerm_virtual_network.Spoke-vnet : k => v.name
  }
}