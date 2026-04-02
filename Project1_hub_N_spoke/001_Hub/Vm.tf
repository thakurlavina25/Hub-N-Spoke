# Create a Windows Virtual Machine in Azure using Terraform for the Jumpbox with private IP ###
resource "azurerm_windows_virtual_machine" "Jump-vm" {
  name                = var.VmName
  resource_group_name = azurerm_resource_group.hub_rg.name
  location            = azurerm_resource_group.hub_rg.location
  size                = var.vmsize
  admin_username      = var.username
  admin_password      = azurerm_key_vault_secret.secret.value # The password for the VM will be stored in Azure Key Vault #
  network_interface_ids = [
    azurerm_network_interface.NIC.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = var.sku
    version   = "latest"
  }
  depends_on = [ azurerm_network_interface.NIC , azurerm_key_vault_secret.secret ]  
  # THE VM creation will depend on the  NIC and  key vault secret ##
}
