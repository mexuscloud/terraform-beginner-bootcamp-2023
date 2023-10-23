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

variable "index_html_filepath" {
  type        = string
  description = "Local file path to the 'index.html' file for uploading to the S3 bucket."

  validation {
    condition = can(file(var.index_html_filepath))
    error_message = "The specified file '${var.index_html_filepath}' does not exist or is not accessible."
  }
}

variable "error_html_filepath" {
  type        = string
  description = "Local file path to the 'error.html' file for uploading to the S3 bucket."

  validation {
    condition = can(file(var.error_html_filepath))
    error_message = "The specified file '${var.error_html_filepath}' does not exist or is not accessible."
  }
}

variable "content_version" {
  type        = number
  description = "The content version (positive integer starting at 1)."

  validation {
    condition     = can(regex("^[1-9][0-9]*$", var.content_version))
    error_message = "content_version must be a positive integer starting at 1."
  }
}

variable "assets_path" {
  description = "path to assets folder"
  type = string  
}
