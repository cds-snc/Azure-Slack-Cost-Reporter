# Please Note: At this time Cost management exports are not availalbe for Billing Accounts in TF so this work was done manually
# Waiting on this issue to be addressed to add it https://github.com/hashicorp/terraform-provider-azurerm/issues/14726

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.63.0"
    }
  }
}


provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
  // Reporting subscription
  subscription_id = "2401a870-e4dd-4c61-ac84-0eaaafdb9039"
}


resource "azurerm_resource_group" "cost_reports" {
  name     = "cost-reports"
  location = "canadaeast"
}

resource "azurerm_storage_account" "cost_reports" {
  name                     = "cdscostmgmtreports"
  resource_group_name      = azurerm_resource_group.cost_reports.name
  location                 = azurerm_resource_group.cost_reports.location
  account_tier             = "Standard"
  account_replication_type = "RAGRS"
}