variable "subscription_id" {
  type    = string
  default = "xxxxxx"
}

variable "client_id" {
  type    = string
  default = "xxxxxx"
}

variable "client_secret" {
  type    = string
  default = "xxxxxx"
}

variable "tenant_id" {
  type    = string
  default = "xxxxxx"
}

variable "name" {
  type    = string
  default = "devops"
}

variable "location" {
  type    = string
  default = "eastasia"
}

variable "security_rule_ops" {
  # type = list(string)
  default = [
    {
      name        = "rule-001"
      source      = "*"
      description = "*"
      action      = "Allow"
      port        = "22"
    },
    {
      name        = "rule-002"
      source      = "*"
      description = "*"
      action      = "Allow"
      port        = "80"
    },
    {
      name        = "rule-003"
      source      = "*"
      description = "*"
      action      = "Allow"
      port        = "443"
    },
  ]
}

