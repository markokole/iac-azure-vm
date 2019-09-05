variable "configuration_type" {}

variable "path_in_consul" {
  default   = "test/master/azure"
}

variable "consul_server" {
  default   = "34.200.245.90"
}

variable "consul_port" {
  default   = "8500"
}

variable "datacenter" {
  default   = "dc1"
}

data "consul_keys" "app" {
  key {
    name    = "path_to_generated_azure_properties"
    path    = "${var.path_in_consul}/path_to_generated_azure_properties"
  }
}

data "consul_keys" "configuration" {
  key {
    name    = "location"
    path    = "${var.path_in_consul}/${var.configuration_type}/location"
  }
}

data "consul_keys" "azure" {
  key {
    name    = "resource_group_name"
    path    = "${local.path_to_generated_azure_properties}/resource_group_name"
  }

  key {
    name    = "virtual_network_id"
    path    = "${local.path_to_generated_azure_properties}/virtual_network_id"
  }

  key {
    name    = "network_interface_id"
    path    = "${local.path_to_generated_azure_properties}/network_interface_id"
  }

  key {
    name    = "subnet_id"
    path    = "${local.path_to_generated_azure_properties}/subnet_id"
  }
}