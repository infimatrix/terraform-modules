resource "google_service_account" "service_account" {
  project      = var.project_id
  account_id   = var.service_account_name
  display_name = var.service_account_name
}

resource "google_project_iam_custom_role" "my_custom_role" {
  project     = var.project_id
  role_id     = var.role_id
  title       = var.role_id
  permissions = var.permissions
}

resource "google_project_iam_member" "project_iam_member" {
  project  = var.project_id
  role     = google_project_iam_custom_role.my_custom_role.id
  member   = "serviceAccount:${google_service_account.service_account.email}"
}

