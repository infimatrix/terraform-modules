locals {

  databases = { for db in var.additional_databases : db.name => db }
  users     = { for users in var.additional_users : users.name => users }

}

resource "google_compute_global_address" "private_ip_address" {
  
  name          = var.ip_name
  purpose       = var.purpose
  address_type  = var.address_type
  prefix_length = var.prefix_length
  network       = var.network
}

resource "google_service_networking_connection" "private_vpc_connection" {

  network                 = var.network
  service                 = var.service
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}


resource "google_sql_database_instance" "instance" {
  name                = var.master_instance_name
  region              = var.region
  database_version    = var.db_version
  deletion_protection = var.deletion_protection

  depends_on = [google_service_networking_connection.private_vpc_connection]

  settings {
    tier              = var.tier
    availability_type = var.availability_type
    ip_configuration {
      ipv4_enabled                                  = true
      private_network                               = var.network
      enable_private_path_for_google_cloud_services = true
    }

    disk_autoresize = var.disk_autoresize

    disk_size    = var.disk_size
    disk_type    = var.disk_type
    pricing_plan = var.pricing_plan
    user_labels  = var.user_labels

    maintenance_window {
      day          = var.maintenance_window_day
      hour         = var.maintenance_window_hour
      update_track = var.maintenance_window_update_track
    }
  }
}

resource "google_sql_user" "default" {
  name     = var.user_name
  instance = google_sql_database_instance.instance.name
  password = var.user_password
  depends_on = [
    google_sql_database_instance.instance,
  ]
}

resource "google_sql_user" "additional_users" {
  for_each = local.users
  name     = each.value.name
  password = each.value.password
  instance = google_sql_database_instance.instance.name
  depends_on = [
    google_sql_database_instance.instance,
  ]
}



resource "google_sql_database" "default" {
  name       = var.db_name
  instance   = google_sql_database_instance.instance.name
  depends_on = [google_sql_database_instance.instance]
}

resource "google_sql_database" "additional_databases" {
  for_each   = local.databases
  name       = each.value.name
  instance   = google_sql_database_instance.instance.name
  depends_on = [google_sql_database_instance.instance]
}