variable "resource_group_name" {
  type    = string
  default = ""
}

variable "location" {
  type    = string
  default = ""
}

variable "network_security_group_name" {
  type    = string
  default = ""
}

variable "tags" {
  type    = string
  default = ""
}

variable "security_rule_ports" {
  type        = list
  default = [
    { name = "rule-001", source = "*", description = "*", action = "Allow", port = "22" },
    { name = "rule-002", source = "*", description = "*", action = "Allow", port = "80" },
    { name = "rule-003", source = "*", description = "*", action = "Allow", port = "443" },
  ]
}
