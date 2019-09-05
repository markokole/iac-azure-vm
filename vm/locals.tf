
locals {
    project                             = "marko-kafka"
    n_vm                                = 3
    datacenter                          = "${var.datacenter}"
    path_to_generated_azure_properties  = "${var.path_in_consul}/${data.consul_keys.app.var.path_to_generated_azure_properties}"
    location                            = "${data.consul_keys.configuration.var.location}"
    resource_group_name                 = "${data.consul_keys.azure.var.resource_group_name}"
    subnet_id                           = "${data.consul_keys.azure.var.subnet_id}"
}
