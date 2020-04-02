variable "name" {
  description = "Name that will be used by this given bucket"
  type        = string
}

variable "base_domain" {
  description = "top level domain where application should respond"
  default     = ""
}

variable "versioning_enabled" {
  description = "This variable when set to `true` enabled versioning feature on S3"
  type        = bool
  default     = false
}

variable "block_public_acls" {
  description = "Whether Amazon S3 should block public ACLs for this bucket"
  type        = bool
  default     = false
}

variable "block_public_policy" {
  description = "Whether Amazon S3 should block public bucket policies for this bucket"
  type        = bool
  default     = false
}

variable "ignore_public_acls" {
  description = "Whether Amazon S3 should ignore public ACLs for this bucket"
  type        = bool
  default     = false
}

variable "restrict_public_buckets" {
  description = " Whether Amazon S3 should restrict public bucket policies for this bucket"
  type        = bool
  default     = false
}

variable "sourceIps" {
  description = "Source IP List to allow access"
  type        = list(string)
  default     = []
}
