provider "azurerm" {
  environment                   = "${var.azure_environment}"
  subscription_id               = "${var.azure_subscription_id}"
  client_id                     = "${var.azure_client_id}"
  client_certificate_path       = "${var.client_certificate_path}"
  client_certificate_password   = "${var.client_certificate_password}"
  tenant_id                     = "${var.azure_tenant_id}"
}

terraform {
  backend "azurerm" {}
}