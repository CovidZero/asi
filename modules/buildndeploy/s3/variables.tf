variable "bucket_name" {
  description = "The S3 bucket that will be used as repository"
}

variable "environment" {
  description = "Name of an environment (e.g. staging, qa, production)"
}

variable "repository_owner" {
  description = "Github repository username"
}

variable "repository_name" {
  description = "GitHub repository name"
}

variable "repository_branch" {
  description = "Github repository branch"
}

variable "github_token" {
  description = "github oauth key"
}

variable "google_map_key" {
  description = "Google Map key"
  default     = ""
}