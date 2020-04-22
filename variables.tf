variable "num_subnets" {
    type            = number
    description     = "number of subnets to provision within virtual network"
    default         = 3
}

variable "security_group_rules" {
  type        = list(object({
    name                  = string
    priority              = number
    protocol              = string
    destinationPortRange  = string
    direction             = string
    access                = string
  }))
  description = "List of security group rules"
}

variable "secret_id" {
  type        = string
  description = "name of secret containing admin password for vms"
}

variable "key_vault" {
  type        = string
  description = "Name of the pre-existing key vault instance"
}

variable "rg2" {
  type        = string
  description = "Name of Lab resource group where key vault exists."
}