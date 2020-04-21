terraform {
  backend "azurerm" {
    resource_group_name  = "mcg_storage"
    storage_account_name = "ametfstate"
    container_name       = "azglobal-serbia"
    key                  = "demos.terraform.tfstate"
  }
}
