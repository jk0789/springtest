terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}

  client_id       = "87b572d5-b79c-4ebf-a979-bcccaccb9440"
  client_secret   = "nez8Q~kNWyRSBgAyuAjiYgQEOAwG8tCV80SibaWW"
  tenant_id       = "2154e3a9-19a3-4870-8e95-08abb8f6d960"
  subscription_id = "89f29eb9-3141-4ac6-8492-6213cd9a6822"
}

# Define the backend configuration for Azure Storage
terraform {
  backend "azurerm" {
    storage_account_name = "demoakscluster"
    container_name       = "demo-aks"
    key                  = "aksinfra.tfstate"
    access_key           = "oYkuqlNj5EJC/XgoE0HOgevZp7N9/oSDc5buCtGBGyhTCJeEFKZEpIgNDbsjlf16bc4BOxBL/viB+AStfUH2+Q=="
  }
}
resource "azurerm_resource_group" "aks_rg" {
  name     = "Demo-aksrg1"
  location = "North Europe"  # Change to your desired Azure region
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "my-aks-cluster"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "Demo-akscluster"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_DS2_v2"  # Change to your desired VM size
  }
service_principal {
    client_id     = "87b572d5-b79c-4ebf-a979-bcccaccb9440"      # Replace with your Service Principal's Client ID
    client_secret = "nez8Q~kNWyRSBgAyuAjiYgQEOAwG8tCV80SibaWW"  # Replace with your Service Principal's Client Secret
  }
}
