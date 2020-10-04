provider "azurerm" {  
  version = "=2.29.0"
  #subscription_id = "<your subID>"
  features {}
}
 
# Azure functions using a Consumption service plan on Windows OS (default option)
resource "azurerm_resource_group" "example" {
  name     = "azure-functions-cptest-rg"
  location = "australiacentral"
}
 
resource "azurerm_storage_account" "example" {
  name                     = "msfunctionsapptestsa"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
 
resource "azurerm_app_service_plan" "example" {
  name                = "azure-functions-test-service-plan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  kind                = "FunctionApp"
 
  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}
 
resource "azurerm_function_app" "example" {
  name                       = "mstest-azure-functions"
  location                   = azurerm_resource_group.example.location
  resource_group_name        = azurerm_resource_group.example.name
  app_service_plan_id        = azurerm_app_service_plan.example.id
  storage_account_name       = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key
}