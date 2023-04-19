resource "databricks_mws_workspaces" "this" {
  provider       = databricks.mws
  account_id     = var.databricks_account_id
  aws_region     = var.region
  workspace_name = local.prefix
  #deployment_name = local.prefix

  credentials_id           = databricks_mws_credentials.this.credentials_id
  storage_configuration_id = databricks_mws_storage_configurations.this.storage_configuration_id
  network_id               = databricks_mws_networks.this.network_id
  lifecycle {
    create_before_destroy = true
  }
  timeouts {
    create = "300s" # or higher value, depending on how long it takes for the workspace to be created
  }
}

output "databricks_host" {
  value = databricks_mws_workspaces.this.workspace_url
  depends_on = [
    databricks_mws_workspaces.this
  ]
}

provider "databricks" {
  alias = "created_workspace"
  host  = databricks_mws_workspaces.this.workspace_url
}

resource "databricks_token" "pat" {
  provider         = databricks.created_workspace
  comment          = "Terraform Provisioning"
  lifetime_seconds = 86400
}

output "databricks_token" {
  value     = databricks_token.pat.token_value
  sensitive = true
}
