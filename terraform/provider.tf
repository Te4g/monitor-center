terraform {
  required_version    = ">= 1.3.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = ">= 1.50.0"
    }

    ovh = {
      source  = "ovh/ovh"
      version = ">= 0.28.1"
    }
  }
}

provider "ovh" {
  endpoint           = "ovh-eu"
  application_key    = var.ovh_application_key
  application_secret = var.ovh_application_secret
  consumer_key       = var.ovh_consumer_key
}

provider "openstack" {
  user_name   = var.openstack_user_name
  password    = var.openstack_password
  auth_url = "https://auth.cloud.ovh.net/v3/"
  region = "GRA11"
  user_domain_name = "Default"
}
