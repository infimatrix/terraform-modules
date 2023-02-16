resource "google_cloud_run_v2_service" "default" {
  name     = var.name
  location = var.location
  ingress  = var.ingress

  template {
    dynamic "volumes" {
      for_each = var.volumes_config
      content {
        name = volumes.value.name
        secret {
          secret       = volumes.value.secret_name
          default_mode = volumes.value.default_mode
          items {
            version = volumes.value.version
            path    = volumes.value.path
            mode    = volumes.value.mode
          }
        }
      }
    }
    containers {
      image = var.image
      dynamic "volume_mounts" {
        for_each = var.container_volume_mounts
        content {
          name       = volume_mounts.value.name
          mount_path = volume_mounts.value.mount_path
        }
      }
    }
  }
}

## Resource block for cloud run service NoAuth(Allow unauthenticated invocations)

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_v2_service.default.location
  service     = google_cloud_run_v2_service.default.name
  policy_data = data.google_iam_policy.noauth.policy_data
}