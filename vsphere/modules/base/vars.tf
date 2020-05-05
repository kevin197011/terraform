variable "vsphere_server" {
  type = string
  default = "172.16.1.201"
}

variable "vsphere_user" {
  type = string
  default = "administrator@vsphere.local"
}

variable "vsphere_password" {
  type = string
  default = "xxxxxx"
}

variable "vsphere_folder" {
  type = string
  default = ""
}

variable "vsphere_host_datastore" {
  type = map
  default = {
    host = "172.16.1.101"
    datastore = "datastore101-2"
  }
}

variable "vm_name" {
  type = string
  default = ""
}

variable "vm_ip" {
  type = string
  default = ""
}

variable "vm_ipv4_gateway" {
  type = string
  default = "172.16.1.1"
}

variable "vm_password" {
  type = string
  default = ""
}

variable "vm_cpu" {
  type = string
  default = "2"
}

variable "vm_mem" {
  type = string
  default = "4096"
}

variable "disk_size" {
  type = string
  default = 50
}