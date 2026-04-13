## Configure a Route Table for the Spoke VNet ##
resource "azurerm_route_table" "Spoke_rt" {
  name                = var.Spoke_rt
  location            = azurerm_resource_group.Spoke_rg.location
  resource_group_name = azurerm_resource_group.Spoke_rg.name
}
#Default route##
resource "azurerm_route" "default_route" {
  name                   = var.default_route
  resource_group_name    = azurerm_resource_group.Spoke_rg.name
  route_table_name       = azurerm_route_table.Spoke_rt.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = var.firewall_private_ip # Assuming the first IP in the firewall subnet is used as the next hop
}
## Associate the Route Table with the Spoke Subnet ##
resource "azurerm_subnet_route_table_association" "rt_assoc" {
  for_each = azurerm_subnet.Spoke-Subnet

  subnet_id      = each.value.id
  route_table_id = azurerm_route_table.Spoke_rt.id
}