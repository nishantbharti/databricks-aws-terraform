variable "databricks_account_username" {}
variable "databricks_account_password" {}
variable "databricks_account_id" {}
variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "tags" {
  default = {}
}

variable "cidr_block" {
  default = "10.4.0.0/16"
}

variable "region" {
  default = "eu-west-1"
}

resource "random_string" "naming" {
  special = false
  upper   = false
  length  = 6
}

locals {
  prefix = "dlfasset-${random_string.naming.result}"
}
