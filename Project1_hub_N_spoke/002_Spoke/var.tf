variable "Spokergname" {
    type = string
}
variable "Spokerglocation" {
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

variable "keyvaultname" {
    type = string
}
variable "Hubrgname" {
    type = string
}
variable "Spoke_rt" {
    type = string
}
variable "default_route" {
    type = string
}
variable "firewall_subnet_prefix" {
  type = list(string)
}