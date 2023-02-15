resource "google_cloudbuild_trigger" "filename-trigger2" {
  location = var.location
  name     = var.name


  github {
    owner = var.owner_name
    name  = var.repo_name
    push {
      branch = var.branch
    }
  }
  substitutions = var.substitutions
  filename = var.filename
}