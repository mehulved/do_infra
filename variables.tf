variable "do_token" {
  description = "Digital Ocean API Token."
}

variable "cloudflare_email" {
  description = "Cloudflare login email address."
}
variable "cloudflare_token" {
  description = "Cloudflare API token."
}

variable "cloudflare_domain" {
  description = "Domain name to manage on cloudflare."
}

variable instance_region {
  default     = "nyc3"
}

variable instance_size {
  default     = "1gb"
}
