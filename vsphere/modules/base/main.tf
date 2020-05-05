resource "vsphere_virtual_machine" "vm" {
  name = var.vm_name
  resource_pool_id = data.vsphere_host.host.resource_pool_id
  datastore_id = data.vsphere_datastore.ds.id
  folder = data.vsphere_folder.folder.path

  num_cpus = var.vm_cpu
  memory = var.vm_mem
  guest_id = data.vsphere_virtual_machine.template.guest_id

  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label = "disk0"
    size = data.vsphere_virtual_machine.template.disks[0].size
    eagerly_scrub = data.vsphere_virtual_machine.template.disks[0].eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks[0].thin_provisioned
    unit_number = 0
  }

  disk {
    label = "disk1"
    datastore_id = data.vsphere_datastore.ds.id
    attach = true
    path = vsphere_virtual_disk.data_volume_01.vmdk_path
    unit_number = 1
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = var.vm_name
        domain = ""
      }

      network_interface {
        ipv4_address = var.vm_ip
        ipv4_netmask = 24
      }

      ipv4_gateway = var.vm_ipv4_gateway
      dns_server_list = [
        "8.8.8.8",
        "1.1.1.1"]
    }
  }

  provisioner "file" {
    source = "modules/scripts/add_disk.sh"
    destination = "/tmp/add_disk.sh"

    connection {
      type = "ssh"
      host = var.vm_ip
      user = "root"
      password = "xxxxxx"
      timeout = "10m"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/add_disk.sh",
      "/tmp/add_disk.sh",
      "rm -rf /tmp/add_disk.sh",
    ]

    connection {
      type = "ssh"
      host = var.vm_ip
      user = "root"
      password = "xxxxxx"
      timeout = "10m"
    }
  }
}