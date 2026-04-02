module "Hub" {
  source                      = "./001_Hub"
  Hubrgname                   = var.Hubrgname
  Hubrglocation               = var.Hubrglocation
  hub_vnet_name               = var.hub_vnet_name
  hub_vnet_address_space      = var.hub_vnet_address_space
  firewall_subnet_prefix      = var.firewall_subnet_prefix
  firewall_mgmt_subnet_prefix = var.firewall_mgmt_subnet_prefix
  jumpbox_subnet              = var.jumpbox_subnet
  jumpbox_subnet_prefix       = var.jumpbox_subnet_prefix
  NIC                         = var.NIC
  keyvaultname                = var.keyvaultnameHub
  VmName                      = var.VmName
  vmsize                      = var.vmsize
  username                    = var.username
  sku                         = var.sku
  Firewall_pip                 = var.Firewall_pip
  Hub_fw                        = var.Hub_fw
}

module "Spoke" {
  source          = "./002_Spoke"
  Spokergname     = var.Spokergname
  Spokerglocation = var.Spokerglocation
  Spoke_Vnet      = var.Spoke_Vnet
  Spoke_Subnet    = var.Spoke_Subnet
  Spoke_VM        = var.Spoke_VM
  keyvaultname    = var.keyvaultnameSpoke
  Hubrgname       = var.Hubrgname
  Spoke_rt        = var.Spoke_rt
  default_route    = var.default_route
  firewall_subnet_prefix = var.firewall_subnet_prefix
}

#  Peering (connect both)
resource "azurerm_virtual_network_peering" "Hub-to-Spoke" {
  for_each = module.Spoke.spoke_vnet_id

  name                      = "Hub-to-${each.key}"
  resource_group_name       = module.Hub.hub_rg_name
  virtual_network_name      = module.Hub.hub_vnet_name
  remote_virtual_network_id = each.value

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
}
resource "azurerm_virtual_network_peering" "Spoke-to-Hub" {
  for_each = module.Spoke.spoke_vnet_id

  name                      = "${each.key}-to-Hub"
  resource_group_name       = var.Spokergname   # or output if inside module
  virtual_network_name      = module.Spoke.spoke_vnet_names[each.key] # or output if inside module
  remote_virtual_network_id = module.Hub.hub_vnet_id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  use_remote_gateways          = true
}