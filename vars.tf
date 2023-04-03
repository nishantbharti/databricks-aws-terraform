variable "nishant.bharti01@gmail.com" {}
variable "N@nishant18" {}
variable "4e399bef-a480-43e9-b1aa-e407d5443409" {}

variable "tags" {
  default = {}
}

variable "cidr_block" {
  default = "10.4.0.0/16"
}

variable "region" {
  default = "eu-west-1"
}

// See https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
resource "random_string" "naming" {
  special = false
  upper   = false
  length  = 6
}

locals {
  prefix = "demo-${random_string.naming.result}"
}