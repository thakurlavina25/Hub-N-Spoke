### Spoke Virtual Network and Subnets ###
resource "azurerm_virtual_network" "Spoke-vnet" {
  for_each = var.Spoke_Vnet
  name                = each.key
  address_space       = each.value.address_space
  location            = azurerm_resource_group.Spoke_rg.location
  resource_group_name = azurerm_resource_group.Spoke_rg.name
}
#Spoke Subnet
resource "azurerm_subnet" "Spoke-Subnet" {
  for_each = var.Spoke_Subnet
  name                 = each.key
  resource_group_name  = var.Spokergname
  virtual_network_name = azurerm_virtual_network.Spoke-vnet[each.value.vnet_name].name
  address_prefixes     = each.value.address_space
  depends_on = [ azurerm_virtual_network.Spoke-vnet ]
}
#Spoke NIC
resource "azurerm_network_interface" "Spoke-NIC" {
  for_each = var.Spoke_Subnet
  name                = "NIC-${each.key}"
  location            = azurerm_resource_group.Spoke_rg.location
  resource_group_name = azurerm_resource_group.Spoke_rg.name

  ip_configuration {
    name                          = "ipconfig-${each.key}"
    subnet_id                     = azurerm_subnet.Spoke-Subnet[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}