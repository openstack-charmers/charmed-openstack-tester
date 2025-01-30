terraform {
  required_providers {
    juju = {
      source  = "juju/juju"
      version = "~> 0.16.0"
    }
  }
}

provider "juju" {}

locals {
  keystone_channels = tomap(
    {
      "ubuntu@24.04" : "latest/edge",
      "ubuntu@22.04" : "yoga/stable",
      "ubuntu@20.04" : "ussuri/stable",
    }
  )
  mysql_channels = tomap(
    {
      "ubuntu@24.04" : "latest/edge",
    }
  )
  cloud_config = <<-EOT
  #cloud-config
    apt:
      sources:
        overlay-ppa-security:
          source: ppa:ubuntu-security-proposed/ppa
  EOT
}

resource "juju_model" "mysql_testing" {
  name = "mysql-regression-testing"

  config = {
    logging-config              = "<root>=DEBUG"
    development                 = true
    update-status-hook-interval = "1m"
    cloudinit-userdata          = local.cloud_config
  }
}

resource "juju_application" "keystone" {
  name = "keystone"

  model = juju_model.mysql_testing.name

  charm {
    name    = "keystone"
    channel = lookup(local.keystone_channels, var.ubuntu-base, "latest/edge")
    base    = var.ubuntu-base
  }

  config = {
    admin-password = "admin"
  }

  units = 1
}


resource "juju_application" "keystone_mysqlrouter" {
  name = "keystone-mysqlrouter"

  model = juju_model.mysql_testing.name

  charm {
    name    = "mysql-router"
    channel = lookup(local.mysql_channels, var.ubuntu-base, "8.0/stable")
    base    = var.ubuntu-base
  }
}


resource "juju_application" "mysql" {
  name = "mysql"

  model = juju_model.mysql_testing.name

  charm {
    name    = "mysql-innodb-cluster"
    channel = lookup(local.mysql_channels, var.ubuntu-base, "8.0/stable")
    base    = var.ubuntu-base
  }

  units = 3
}

resource "juju_integration" "router_mysql" {
  model = juju_model.mysql_testing.name

  application {
    name     = juju_application.keystone_mysqlrouter.name
    endpoint = "db-router"
  }

  application {
    name     = juju_application.mysql.name
    endpoint = "db-router"
  }
}

resource "juju_integration" "keystone_router" {
  model = juju_model.mysql_testing.name

  application {
    name     = juju_application.keystone.name
    endpoint = "shared-db"
  }

  application {
    name     = juju_application.keystone_mysqlrouter.name
    endpoint = "shared-db"
  }
}

