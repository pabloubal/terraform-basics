terraform {
  required_providers {
    heroku = {
      source  = "heroku/heroku"
      version = "~> 4.8.0"
    }
  }
}

variable "apps_names" {
  type = string
}

variable "source_path" {
  type = string
}

locals {
  apps = toset(split(",", var.apps_names))
}

resource "heroku_app" "app" {
  for_each = local.apps
  name   = each.value
  region = "eu"
}

resource "heroku_build" "app_build" {
  depends_on = [
    heroku_addon.database
  ]
  for_each = heroku_app.app
  app = each.value.id
  source {
    path = var.source_path
  }
}

resource "heroku_addon" "database" {
  for_each = heroku_app.app
  app  = each.value.name
  plan = "heroku-postgresql:hobby-dev"

  provisioner "local-exec" {
    command = "psql -Atx ${self.config_var_values.DATABASE_URL} -f ./resources/schema.sql"
  }
}

output "app_output" {
    value = heroku_app.app
    sensitive = true
}

output "web_url" {
  value = heroku_app.app
  sensitive = true
}

