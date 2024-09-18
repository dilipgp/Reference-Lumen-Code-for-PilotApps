terraform {
backend "azurerm" {
    resource_group_name  = "rg-tnd-terraformState"
    storage_account_name = "packerinstallstorage33"
    container_name       = "terraform"
    key                  = "avdmultideploy.tfstate"
    }
}