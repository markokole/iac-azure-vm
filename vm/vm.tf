resource "azurerm_public_ip" "main" {
  count                   = "${local.n_vm}"
  name                    = "${local.project}${count.index}-pip"
  location                = "${local.location}"
  resource_group_name     = "${local.resource_group_name}"
  allocation_method       = "Static"
  idle_timeout_in_minutes = 30
  domain_name_label       = "${local.project}${count.index}"
}

resource "azurerm_network_interface" "main" {
  count               = "${local.n_vm}"
  name                = "${local.project}${count.index}-nic"
  location            = "${local.location}"
  resource_group_name = "${local.resource_group_name}"

  ip_configuration {
    name                          = "${local.project}${count.index}-nic-ip-conf"
    subnet_id                     = "${local.subnet_id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${element(azurerm_public_ip.main.*.id, count.index)}"
  }
}

resource "azurerm_virtual_machine" "main" {
  count                 = "${local.n_vm}"
  name                  = "${local.project}${count.index}-vm"
  location              = "${local.location}"
  resource_group_name   = "${local.resource_group_name}"
  network_interface_ids = ["${element(azurerm_network_interface.main.*.id, count.index)}"]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "openlogic"
    offer     = "CentOS"
    sku       = "7.2"
    version   = "latest"
  }
  storage_os_disk {
    name              = "${local.project}${count.index}-vm-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "${local.project}${count.index}"
    admin_username = "centos"
  }
  
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
        path     = "/home/centos/.ssh/authorized_keys"
        key_data = "${file("/root/.ssh/id_rsa.pub")}"
    }
  }
}

/*
resource "null_resource" "copy_id_rsa" {
  depends_on = ["azurerm_virtual_machine.main"]
  count = "${local.n_vm}"
  provisioner "local-exec" {
    command = <<EOF
scp -i /root/.ssh/id_rsa /root/.ssh/id_rsa centos@${element(azurerm_public_ip.main.*.ip_address, count.index)}:/home/centos/.ssh
EOF
     }
}*/