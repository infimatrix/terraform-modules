variable "location" {
  default = "asia-east1"
  type    = string
}

variable "name" {
  type = string
}

variable "filename" {
  type = string
}

variable "owner_name" {
  type = string
}

variable "repo_name" {
  type = string
} 

variable "branch" {
  type = string
  default = "^main$"
}

variable "substitutions" {
  type = map(string)
}