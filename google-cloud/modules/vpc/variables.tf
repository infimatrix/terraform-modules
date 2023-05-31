variable "project_id" {
  type = string
  default = "mantis-dev001"
}
variable "location" {
  type = string
  default = "asia-south1"
}
variable "gcp_auth_file" {
  type        = string
  description = "GCP authentication file"
  default = "../.././sa.json"
}

variable "vpc_name" {
  type = string
  default = "mantis-test-vpc"
}

variable "auto_create_subnetworks" {
  type = bool
  default = false
}

variable "delete_default_routes_on_create" {
  type = bool
  default = true
}