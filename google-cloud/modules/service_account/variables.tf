variable "project_id" {
  type    = string
}

variable "service_account_name" {
  type = string
  default = "gke-sa"
}

variable "role_id" {
  description = "The camel case role id to use for this role."
  default = "mantis_test_gke_roles"
}

variable "permissions" {
  description = "The names of the permissions this role grants when bound in an IAM policy. "
  default = [
          "container.clusters.get",
          "storage.buckets.get",
          "storage.buckets.list",
          "storage.objects.get",
          "storage.objects.list",
          "container.clusters.get",
  ]
}