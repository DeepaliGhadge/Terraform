terraform {
  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
    tls = {
      source = "hashicorp/tls"
      version = "~>4.0"
    }
  }
}

provider "azurerm" {
  subscription_id="8659e423-a7ae-4e8f-9d43-3f63027b6e19"
  tenant_id="b3729ee8-cde4-407d-9f7b-7316a3be9359"
  client_id ="8bd181e4-43f8-465c-b294-410c3508622e"
  client_secret="H1K8Q~y.90l6tUMbSDEGvvtgPxVb5y9hoAhRcaXY"
  features {}
 }