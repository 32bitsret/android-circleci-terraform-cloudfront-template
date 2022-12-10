provider "acme" {
  server_url = "${var.acme_server_url}"
}

provider "aws" {
  alias   = "us_east_1"
  region  = "us-east-1"
}

resource "tls_private_key" "acme_registration_private_key" {
  algorithm = "RSA"
}

resource "acme_registration" "registration" {
  account_key_pem = "${tls_private_key.acme_registration_private_key.private_key_pem}"
  email_address   = "${var.acme_registration_email}"
}

resource "acme_certificate" "certificate" {
  account_key_pem         = acme_registration.registration.account_key_pem
  common_name             = "${var.domain}"
  subject_alternative_names = ["${var.domain}"] #required by cloudfront


  dns_challenge {
    provider = "route53"

    config = {
        AWS_HOSTED_ZONE_ID = var.domain_r53_host_id
    }    
  }
}

resource "aws_acm_certificate" "certificate" {
  provider          = aws.us_east_1
  certificate_body  = acme_certificate.certificate.certificate_pem
  private_key       = acme_certificate.certificate.private_key_pem
  certificate_chain = acme_certificate.certificate.issuer_pem

  tags = {
    "organization" = "${var.organization}"
  }
}