resource "google_storage_bucket" "backend_bucket" {
  project = var.project_id
  name          = var.bucket_name
  location      = var.location
  force_destroy = var.force_destroy

  public_access_prevention = var.public_access_prevention
  versioning {
    enabled = true
  }
}