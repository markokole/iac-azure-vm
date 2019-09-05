# Provisioning Virtual Machines in Azure
*Work in Progress!*

The idea is to provision a cluster of virtual machines that will be further used for installing open-source technologies (Kafka, SPark, Cassandra,...)

This repository provisions a number of virtual machines in Azure. The idea is to use Consul to define the cluster of linux machines one wishes to provision. At the moment, the configuration is done through *locals.tf* file, but this should be fixed soon.

The repository relies on the key-value pairs in Consul written by the [infra repository](https://github.com/markokole/iac-azure-infra) repository.

The provisioning writes to Consul the following keys:
> test/master/azure/generated/[PROJECT_NAME]/private_ip_address
> test/master/azure/generated/[PROJECT_NAME]/public_dns_address
> test/master/azure/generated/[PROJECT_NAME]/public_ip_address

Once these pairs are in place, any project that needs to build on a cluster of virtual machines can use them.
