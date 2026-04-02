### The resource group for Spoke networks ###
resource "azurerm_resource_group" "Spoke_rg" {
  name     = var.Spokergname
  location = var.Spokerglocation
}

# Random Block
resource "random_string" "Password" {
  length           = 12
  special          = true
  upper            = true
}

data "azurerm_client_config" "current"{}               # to pull the data from azure portal
# Create an Azure Key Vault
resource "azurerm_key_vault" "kv" {
  name                        = var.keyvaultname # must be globally unique
  location                    = azurerm_resource_group.Spoke_rg.location
  resource_group_name          = azurerm_resource_group.Spoke_rg.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  rbac_authorization_enabled  = true
}
resource "azurerm_role_assignment" "kv_admin" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}

# to add secret
resource "azurerm_key_vault_secret" "secret" {
  name         = "Password"
  value        = random_string.Password.result             #creting password and save to key vault 
  key_vault_id = azurerm_key_vault.kv.id
    depends_on = [
    azurerm_role_assignment.kv_admin
  ]
}