# Terraform variables for Hub Network Deployment in Azure #
variable "Hubrgname" {
  type = string
}
variable "Hubrglocation" {
  type = string
}
variable "hub_vnet_name" {
  type = string
}
variable "hub_vnet_address_space" {
  type = list(string)
}
variable "firewall_subnet_prefix" {
  type = list(string)
}
variable "firewall_mgmt_subnet_prefix" {
  type = list(string)
}
variable "jumpbox_subnet" {
  type = string
}
variable "jumpbox_subnet_prefix" {
  type = list(string)
}
variable "NIC" {
  type = string
}
variable "keyvaultnameHub" {
  type = string
}
variable "VmName" {
  type = string
}
variable "vmsize" {
  type = string
}
variable "username" {
  type = string
}
variable "sku" {
  type = string
}
variable "Firewall_pip" {
    type = string
}
variable "Hub_fw" {
    type = string
}

# Terraform variables for Spoke Network Deployment in Azure #
variable "Spokergname" {
  type = string
}
variable "Spokerglocation" {
  type = string
}
variable "keyvaultnameSpoke" {
  type = string
}
variable "Spoke_rt" {
    type = string
}
variable "default_route" {
    type = string
}
variable "Spoke_Vnet" {
  type = map(object({
    address_space = list(string)
  }))
}

variable "Spoke_Subnet" {
  type = map(object({
    address_space = list(string)
    vnet_name     = string
  }))
}

variable "Spoke_VM" {
  type = map(object({
    size           = string
    admin_username = string
    sku            = string
    nic_name  = string
  }))
}
