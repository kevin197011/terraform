data "vsphere_datacenter" "dc" {
  name = "Datacenter"
}

data "vsphere_host" "host" {
  name = var.vsphere_host_datastore.host
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "ds" {
  name = var.vsphere_host_datastore.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name = "VM Network"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_folder" "folder" {
  path = var.vsphere_folder
}

data "vsphere_virtual_machine" "template" {
  name = "centos-7-base"
  datacenter_id = data.vsphere_datacenter.dc.id
}
