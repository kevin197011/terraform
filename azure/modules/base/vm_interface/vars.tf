
variable "resource_group_name" {
  type        = string
  default     = ""
}

variable "location" {
  type        = string
  default     = "eastasia"
}

variable "tags" {
  type        = string
  default     = ""
}

variable "node_name" {
  type        = string
  default     = ""
}

variable "nsg_id" {
  type        = string
  default     = ""
}

variable "subnet_id" {
  type        = string
  default     = ""
}

variable "node_private_ip" {
  type        = string
  default     = ""
}

variable "public_ip_address_id" {
  type        = string
  default     = ""
}

variable "node_hostname" {
  type        = string
  default     = ""
}

variable "backend_pool_id" {
  type        = string
  default     = ""
}

variable "availability_set_id" {
  type        = string
  default     = ""
}

variable "vm_size" {
  type        = string
  default     = "Standard_A1_v2"
}

variable "admin_username" {
  type        = string
  default     = "ops"
}

variable "admin_password" {
  type        = string
  default     = "xxxxxx"
}