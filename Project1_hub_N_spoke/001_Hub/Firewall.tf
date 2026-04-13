## Configure a Public IP for the Azure Firewall ##
resource "azurerm_public_ip" "Firewall_pip" {
  name                = var.Firewall_pip
  location            = azurerm_resource_group.hub_rg.location
  resource_group_name = azurerm_resource_group.hub_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

## Configure the Azure Firewall in the Hub VNet ##
resource "azurerm_firewall" "Hub_fw" {
  name                = var.Hub_fw
  location            = azurerm_resource_group.hub_rg.location
  resource_group_name = azurerm_resource_group.hub_rg.name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "fw-ipconfig"
    subnet_id            = azurerm_subnet.fw_subnet.id
    public_ip_address_id = azurerm_public_ip.Firewall_pip.id
  }
}

## Firewall Rules ##
resource "azurerm_firewall_network_rule_collection" "allow_outbound" {
  name                = "allow-internet"
  azure_firewall_name = azurerm_firewall.Hub_fw.name
  resource_group_name = azurerm_resource_group.hub_rg.name
  priority            = 100
  action              = "Allow"
  depends_on = [ azurerm_firewall.Hub_fw ]

  rule {
    name = "allow-web"

    source_addresses      = ["*"]
    destination_ports     = ["80", "443"]
    destination_addresses = ["*"]
    protocols             = ["TCP"]
  }
}