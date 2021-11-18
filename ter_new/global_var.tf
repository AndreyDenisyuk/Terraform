variable location {
  default     = "West Europe"
  description = "location RG"
}

variable name_rg {
  default     = "rg_andrei_dzenisiuk"
  description = "nane RG"
}

variable name_app_service_plan {
  default     = "app_ser_pl_ADV"
  description = "name APP service plan"
}

variable name_web_app {
  default     = "webappADV"
  description = "name Web app"
}

variable name_SQL_serv {
  default     = "sql-serv-adv"
  description = "name SQL serv"
}
 
variable admin_login {
  default     = "andreidzenisiuk"
  description = "administrator login"
}

variable admin_passwd {
  default     = "Andrei-Dzenisiuk11081982"
  description = "administrator password"
}

variable name_sa {
  default     = "fylhtqsa"
  description = "name storage account"
}

variable name_DB_SQL {
  default     = "DBSQLADV"
  description = "name DB SQL"
}
variable name_app_insights {
  default     = "appinsadv"
  description = "name application insights"
}

variable name_applic_type {
  default     = "web"
  description = "name application type"
}






variable tag {
  type        = map
  default     = {
      tag  = "andrei_dzenisiuk"
      Project ="my_lab"
      environment = "DEV"
    }
}

variable myname {
  default     = "andrei-dzenisiuk"
}

variable shortname {
  default     = "anddzen"
}


variable env {
  default     = "env"
}




