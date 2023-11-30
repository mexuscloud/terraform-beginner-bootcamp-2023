variable "teacherseat_user_uuid" {
  type = string
}

variable "terratowns_access_token" {
  type = string
}

variable "terratowns_endpoint" {
  type = string
}

variable "FIFA" {
  type = object({
    public_path = string
    content_version = number
  })
}

variable "KeyLime" {
  type = object({
    public_path = string
    content_version = number
  })
}