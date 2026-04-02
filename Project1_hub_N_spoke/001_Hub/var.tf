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
variable "keyvaultname" {
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

