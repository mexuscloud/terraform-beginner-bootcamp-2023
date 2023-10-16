variable "user_uuid" {
  description = "The user's UUID"
  type        = string

  validation {
    condition = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.user_uuid))
    error_message = "The user_uuid must be a valid UUID in the format 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'."
  }
}

variable "bucket_name" {
  description = "The name of the AWS S3 bucket"
  type        = string

  validation {
    condition = can(regex("^[a-z0-9][a-z0-9.-]{1,61}[a-z0-9]$", var.bucket_name))
    error_message = "The bucket_name must be a valid AWS S3 bucket name: must start with a lowercase letter or number, between 3 and 63 characters in length, and can only contain lowercase letters, numbers, hyphens, or periods."
  }
}
