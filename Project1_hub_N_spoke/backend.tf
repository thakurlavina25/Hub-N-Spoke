terraform {
backend "azurerm" {
resource_group_name = "storage1" # Azure resource group containing the storage account
storage_account_name = "lavistorage" # Name of the Azure storage account
container_name = "container1" # Blob container to store the state file
key = "terraform.tfstate" # Name of the state file in the container
}
}