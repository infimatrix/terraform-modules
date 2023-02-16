variable "name" {
  description = "Name of the cloudRun service"
  type = string
}

variable "location" {
  description = "Location of the cloudRun service"
  type = string
}

variable "ingress" {
  description = "Ingress traffic"
  type = string
}


variable "volumes_config" {
  description = "List of volume configurations"
  type = list(object({
    name         = string
    secret_name  = string
    default_mode = number
    version      = string
    path         = string
    mode         = number
  }))
  default = [
    {
      name         = "a-volume"
      secret_name  = "tf-secret"
      default_mode = 292
      version      = "1"
      path         = "my-secret"
      mode         = 256
    }
  ]
}

variable "image" {
  description = "Name of the image use to create cloud run service"
  type = string
}

variable "container_volume_mounts" {
  description = "List of volume mount configurations for the containers"
  type = list(object({
    name       = string
    mount_path = string
  }))
  default = [{
    mount_path = "/secrets"
    name       = "a-volume"
  }]
}