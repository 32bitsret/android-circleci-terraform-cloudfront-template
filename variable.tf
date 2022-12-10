# The application's name
variable "app" {
  default = "apkupdate-template"
}

variable "domain" {
  default = "apkupdate.logicaladdress.com"
}

variable "region" {
  default = "us-west-2"
}
 
variable "root_domain" {
  default = "logicaladdress.com"
}

variable "acme_registration_email" {
  default = "dretnan@logicaladdress.com"
}

variable "acme_server_url" {
  default = "https://acme-v02.api.letsencrypt.org/directory"
}

variable "domain_r53_host_id" {
  default = "Z0523474J6W1VLYQ0QSS"
}

variable "organization" {
  default = "Logical Address Limited"
} 