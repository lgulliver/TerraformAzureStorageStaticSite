terraform {
  backend "azurerm" {}
}

locals {
    env_prefix = "${var.shortcode}-${var.product}-${var.envname}-${var.location_short_code}"
    env_prefix_no_separator = "${var.shortcode}${var.product}${var.envname}${var.location_short_code}"
}

resource "azurerm_resource_group" "rg" {
  name     = "${local.env_prefix}-rg"
  location = var.location

  tags = {
    product = var.product      
  }
}

resource "azurerm_storage_account" "static_storage" {
  name                     = "${local.env_prefix_no_separator}stor"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "GRS"
  enable_https_traffic_only = true

  static_website {
    index_document = "index.html"
  }

  tags = {
    product = var.product
  }
}