provider "azurerm" {
  environment                   = "${var.azure_environment}"
  subscription_id               = "${var.azure_subscription_id}"
  client_id                     = "${var.azure_client_id}"
  client_certificate_path       = "${var.client_certificate_path}"
  client_certificate_password   = "${var.client_certificate_password}"
  tenant_id                     = "${var.azure_tenant_id}"
}

resource "azurerm_resource_group" "grp" {
  name     = "jenkins-group"
  location = "${var.location}"
}

resource "azurerm_container_group" "container-grp" {
  name                = "jenkins-continst"
  location            = "${azurerm_resource_group.grp.location}"
  resource_group_name = "${azurerm_resource_group.grp.name}"
  ip_address_type     = "public"
  dns_name_label      = "${var.prefix}01"
  os_type             = "Linux"

  container {
    name   = "jenkins"
    image  = "jenkins/jenkins:lts-alpine"
    cpu    = "1"
    memory = "1"

    ports {
      port     = 8080
      protocol = "TCP"
    }

    volume{
      name                  = "jenkinsvol1"
      mount_path            = "/var/jenkins_home"
      storage_account_name  = "${var.jenkins_data_storage_acct}"
      storage_account_key   = "${var.jenkins_data_storage_acct_key}"
      share_name            = "${var.jenkins_data_storage_acct_share}"
    }
   
  }

  tags = {
    environment = "${var.environment}"
  }
}