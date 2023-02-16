variable "location" {
  description = "Location of cloud build trigger to be created"
  default = "asia-east1"
  type    = string
}

variable "name" {
  description = "Name of cloud build trigger to be created"
  type = string
}

variable "filename" {
  description = "File name where the Yaml code present for build"
  type = string
}

variable "owner_name" {
  description = "The owner name of repo to be used for trigger"
  type = string
}

variable "repo_name" {
  description = "The repo name to be used for trigger"
  type = string
} 

variable "branch" {
  description = "The branch name of github/source repo"
  type = string
  default = "^main$"
}

variable "substitutions" {
  description = "The labels we want to add on trigger"
  type = map(string)
}