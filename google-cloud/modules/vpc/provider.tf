provider "google" {
  project = var.project_id
  credentials = file(var.gcp_auth_file)
  region  = var.location
}