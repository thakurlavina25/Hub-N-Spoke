# Terraform variables for Hub Network Deployment in Azure #
Hubrgname                   = "hub-rg"
Hubrglocation               = "EastUS"
hub_vnet_name               = "hub-vnet"
hub_vnet_address_space      = ["172.30.0.0/16"]
firewall_subnet_prefix      = ["172.30.1.0/26"]
firewall_mgmt_subnet_prefix = ["172.30.2.0/26"]
jumpbox_subnet              = "jumpbox-subnet"
jumpbox_subnet_prefix       = ["172.30.3.0/24"]
NIC                         = "jumpbox-nic"
keyvaultnameHub             = "keyvaultHub123456"
VmName                      = "jumpbox-vm"
vmsize                      = "Standard_B1ms"
username                    = "admin100"
sku                         = "2022-datacenter"
Firewall_pip                 = "fw-pip"
Hub_fw                        = "Hub-Firewall"

# Terraform variables for Spoke Network Deployment in Azure #
Spokergname     = "Spoke-rg"
Spokerglocation = "CentralUs"
keyvaultnameSpoke   = "keyvaultSpoke123456"

Spoke_Vnet = {
  Dev-vnet = {
    address_space = ["192.30.0.0/16"]
  }
  Prod-vnet = {
    address_space = ["192.31.0.0/16"]
  }
}
Spoke_Subnet = {
  Dev-Subnet = {
    address_space = ["192.30.1.0/24"]
    vnet_name     = "Dev-vnet"
  }
  Prod-Subnet = {
    address_space = ["192.31.1.0/24"]
    vnet_name     = "Prod-vnet"

  }
}
Spoke_VM = {
  Dev-VM = {
    size           = "Standard_B1s"
    admin_username = "admin100"
    sku            = "2022-Datacenter"
    nic_name = "Dev-Subnet"
  }
  Prod-VM = {
    size           = "Standard_B1s"
    admin_username = "admin100"
    sku            = "2022-Datacenter"
    nic_name = "Prod-Subnet"
  }
}
Spoke_rt = "Spoke-RouteTable"
default_route = "route-to-firewall"