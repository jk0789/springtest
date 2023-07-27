provider "azurerm" {
  features {}
}

# Define the backend configuration for Azure Storage
terraform {
  backend "azurerm" {
    storage_account_name = "demoakscluster"
    container_name       = "demo-aks"
    key                  = "aksinfra.tfstate"
  }
}
resource "azurerm_resource_group" "aks_rg" {
  name     = "Demo-aksrg"
  location = "East US"  # Change to your desired Azure region
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
    client_id     = "87b572d5-b79c-4ebf-a979-bcccaccb9440"  # Replace with your Azure Service Principal client_id
    client_secret = "nez8Q~kNWyRSBgAyuAjiYgQEOAwG8tCV80SibaWW"  # Replace with your Azure Service Principal client_secret
  }

}
