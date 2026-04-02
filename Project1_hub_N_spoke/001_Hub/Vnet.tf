### Hub Virtual Network and Subnets ###
resource "azurerm_virtual_network" "hub-vnet" {
  name                = var.hub_vnet_name
  address_space       = var.hub_vnet_address_space
  location            = azurerm_resource_group.hub_rg.location
  resource_group_name = azurerm_resource_group.hub_rg.name
}

# Firewall Subnet
resource "azurerm_subnet" "fw_subnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.hub_rg.name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes     = var.firewall_subnet_prefix
}

# Management Subnet (Optional)
resource "azurerm_subnet" "fw_mgmt_subnet" {
  name                 = "AzureFirewallManagementSubnet"
  resource_group_name  = azurerm_resource_group.hub_rg.name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes     = var.firewall_mgmt_subnet_prefix
}
# Jump box Subnet
resource "azurerm_subnet" "jumpbox_subnet" {
  name                 = var.jumpbox_subnet
  resource_group_name  = azurerm_resource_group.hub_rg.name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes     = var.jumpbox_subnet_prefix
}

resource "azurerm_network_interface" "NIC" {
  name                = var.NIC
  location            = azurerm_resource_group.hub_rg.location
  resource_group_name = azurerm_resource_group.hub_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.jumpbox_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}