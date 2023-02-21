resource "google_cloud_run_v2_service" "default" {
  name     = var.name
  location = var.location
  ingress  = var.ingress

  template {
    scaling {
      max_instance_count = var.max_instance_count
    }
    dynamic "volumes" {
      for_each = var.volumes
      content {
        name = volumes.value.volume_name
        cloud_sql_instance {
          instances = volumes.value.instances
        }
      }
    }

    containers {
      image = var.container_image
      ports {
                  container_port = var.container_port
                }

      dynamic "env" {
        for_each = var.env_vars
        content {
          name = env.key
          value = env.value
        }
      }


      dynamic "volume_mounts" {
        for_each = var.volume_mounts
        content {
          name = volume_mounts.value.name
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