terraform {
  backend "gcs" {
    bucket = "terraform-remote-state-backend-bucket"
    prefix = "terraform/state/gke"
  }
}
