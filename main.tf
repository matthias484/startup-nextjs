terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

# Variable für das Azure-Abonnement
variable "azure_subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

# AzureRM-Provider konfigurieren
provider "azurerm" {
  features {}
  subscription_id = var.azure_subscription_id
}

# Ressourcengruppe erstellen
resource "azurerm_resource_group" "rg" {
  name     = "rg-devops"
  location = "West Europe"
}

# Container App Environment erstellen
resource "azurerm_container_app_environment" "env" {
  name                = "env-devops"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Container App erstellen
resource "azurerm_container_app" "app" {
  name                         = "app-startup-nextjs"
  resource_group_name          = azurerm_resource_group.rg.name
  container_app_environment_id = azurerm_container_app_environment.env.id
  revision_mode                = "Single"

  template {
    container {
      name   = "container-startup-nextjs"
      image  = "mwerkl/startup-nextjs:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }

  ingress {
    external_enabled = true
    target_port      = 3000

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }
}
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

# Variable für das Azure-Abonnement
variable "azure_subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

# AzureRM-Provider konfigurieren
provider "azurerm" {
  features {}
  subscription_id = var.azure_subscription_id
}

# Ressourcengruppe erstellen
resource "azurerm_resource_group" "rg" {
  name     = "rg-devops"
  location = "West Europe"
}

# Container App Environment erstellen
resource "azurerm_container_app_environment" "env" {
  name                = "env-devops"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Container App erstellen
resource "azurerm_container_app" "app" {
  name                         = "app-startup-nextjs"
  resource_group_name          = azurerm_resource_group.rg.name
  container_app_environment_id = azurerm_container_app_environment.env.id
  revision_mode                = "Single"

  template {
    container {
      name   = "container-startup-nextjs"
      image  = "mwerkl/startup-nextjs:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }

  ingress {
    external_enabled = true
    target_port      = 3000

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }
}
