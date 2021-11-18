### RG
resource "azurerm_resource_group" "rg_test" {
  name     = var.name_rg
  location = var.location
}

### App service plan
resource "azurerm_app_service_plan" "ASPlan" {
  name                = var.name_app_service_plan
  location            = var.location
  resource_group_name = var.name_rg

  sku {
    tier = "Standard"
    size = "S1"
  }
  depends_on = [
    resource.azurerm_resource_group.rg_test
  ]
}

### Web app
resource "azurerm_app_service" "Webapp" {
  name                = var.name_web_app
  location            = var.location
  resource_group_name = var.name_rg
  app_service_plan_id = azurerm_app_service_plan.ASPlan.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type = "LocalGit"
  }

  app_settings = {
    "key" = "env_test"
  }

  connection_string {
    name = "Database"
    type = "SQLServer"
    value = "Server = tcp:azurerm_sql_server.SQLserver.fully_qualified_domain_name Database = azurerm_sql_database.DBSQL.name; User ID=azurerm_sql_server.SQLserver.administrator_login;Password=azurerm_sql_server.SQLserver.administrator_login_password;Trusted_Connection=False;Encrypt=True;"
  }
}


### SQL server
resource "azurerm_sql_server" "SQLserver" {
  name                         = var.name_SQL_serv
  resource_group_name          = var.name_rg
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.admin_login
  administrator_login_password = var.admin_passwd

  depends_on = [
    resource.azurerm_resource_group.rg_test
  ]
}

### SA
resource "azurerm_storage_account" "SA" {
  name                     = var.name_sa
  resource_group_name      = var.name_rg
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  depends_on = [
    resource.azurerm_resource_group.rg_test
  ]

}

### DB SQL 
resource "azurerm_sql_database" "DBSQL" {
  name                = var.name_DB_SQL
  resource_group_name = var.name_rg
  location            = var.location
  server_name         = var.name_SQL_serv

  extended_auditing_policy {
    storage_endpoint                        = azurerm_storage_account.SA.primary_blob_endpoint
    storage_account_access_key              = azurerm_storage_account.SA.primary_access_key
    storage_account_access_key_is_secondary = true
    retention_in_days                       = 6
  }
  depends_on = [
    resource.azurerm_sql_server.SQLserver
  ]
}

### Application insight
resource "azurerm_application_insights" "APPins" {
  name                = var.name_app_insights
  location            = var.location
  resource_group_name = var.name_rg
  application_type    = var.name_applic_type

  depends_on = [
    resource.azurerm_resource_group.rg_test
  ]

}


#output "instrumentation_key" {
#  value = azurerm_application_insights.APPins.instrumentation_key
#}

##output "app_id" {
#  value = azurerm_application_insights.APPins.app_id
#}
