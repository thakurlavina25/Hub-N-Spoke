# Create a Windows Virtual Machine in Azure using Terraform for the Spoke Network with private IP ###
resource "azurerm_windows_virtual_machine" "Spoke_vm" {
  for_each = var.Spoke_VM
  name                = each.key
  resource_group_name = azurerm_resource_group.Spoke_rg.name
  location            = azurerm_resource_group.Spoke_rg.location
  size                = each.value.size
  admin_username      = each.value.admin_username
  admin_password      = azurerm_key_vault_secret.secret.value # Fetching the password from Azure Key Vault
  network_interface_ids = [
    azurerm_network_interface.Spoke-NIC[each.value.nic_name].id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = each.value.sku
    version   = "latest"
  }
  depends_on = [ azurerm_network_interface.Spoke-NIC ]
}
