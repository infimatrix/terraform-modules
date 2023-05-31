variable "project_id" {
  type    = string
  default = "mantis-dev001"
}
variable "location" {
  type    = string
  default = "us-central1"
}
variable "gcp_auth_file" {
  type        = string
  description = "GCP authentication file"
  default     = "../.././sa.json"
}