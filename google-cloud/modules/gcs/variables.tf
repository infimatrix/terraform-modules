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

variable "bucket_name" {
  type = string
  default = "terraform-remote-state-backend-bucket"
}

variable "force_destroy" {
  type = bool
  default = true
}

variable "public_access_prevention" {
  type = string
  default = "enforced"
}