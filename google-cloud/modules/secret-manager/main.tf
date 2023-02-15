resource "google_secret_manager_secret" "secret" {
  secret_id = var.secret_id

  labels = var.labels

  replication {
    automatic = var.replication
  }
}

resource "google_secret_manager_secret_version" "secret-version" {
  secret = google_secret_manager_secret.secret.id

  secret_data = var.secret_data
}

