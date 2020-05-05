variable "resource_group_name" {
  type        = string
  default     = ""
}

variable "location" {
  type        = string
  default     = "eastasia"
}

variable "tags" {
  type    = string
  default = "devops"
}

variable "network_name" {
  type    = string
  default = "devops_network"
}

variable "network_address_space" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_name" {
  type    = string
  default = "devops_subnet"
}

variable "subnet_address_prefix" {
  type    = string
  default = "10.0.1.0/24"
}
