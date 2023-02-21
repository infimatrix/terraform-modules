variable "name" {
  description = "Name of the cloudRun service"
  type = string
  default = "tf-wordpress-svc"
}

variable "location" {
  description = "Location of the cloudRun service"
  type = string
  default = "europe-west1"
}

variable "ingress" {
  description = "Ingress traffic"
  type = string
  default = "INGRESS_TRAFFIC_ALL"
}

variable "max_instance_count" {
  description = "Maximum no of instance count"
  type = string
  default = "2"
}

variable "volumes" {
  type = list(object({
    volume_name = string
    instances = list(string)
  }))
  default = [ {
    instances = [ "gcp-test-377205:europe-west1:wordpress-sql-instance" ]
    volume_name = "cloudsql"
  } ]
}


variable "container_image" {
  description = "Name of the image use to create cloud run service"
  type = string
  default = "gcr.io/gcp-test-377205/wordpressapp@sha256:f5ef49b74ce88291e72f2cee52fb13300a0962ee218972212d2e1e2017edfd05"
}

variable "container_port" {
  description = "Name of the container port used in cloud run service"
  type = string
  default = "80"
}

variable "env_vars" {
  type = map(string)
  default = {
    "DB_USER" = "root"
    "DB_NAME" = "wordpress"
    "DB_PASSWORD" = "Rahul123"
    "DB_HOST" = ":/cloudsql/gcp-test-377205:europe-west1:wordpress-sql-instance"
  }
}

variable "volume_mounts" {
  description = "List of volume mount configurations for the containers"
  type = list(object({
    name       = string
    mount_path = string
  }))
  default = [{
    mount_path = "/cloudsql"
    name       = "cloudsql"
  }]
}