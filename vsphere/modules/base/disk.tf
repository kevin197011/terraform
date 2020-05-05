resource "vsphere_virtual_disk" "data_volume_01" {
  size = var.disk_size
  vmdk_path = "${var.vm_name}-data-01.vmdk"
  datacenter = data.vsphere_datacenter.dc.name
  datastore = data.vsphere_datastore.ds.name
  type = "eagerZeroedThick"

  # lifecycle {
  #   prevent_destroy = true
  # }
}
