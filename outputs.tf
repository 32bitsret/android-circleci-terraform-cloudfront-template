#The domain name corresponding to the distribution. For example: d604721fxaaqy9.cloudfront.net.
output "cf_domain_name" {
  value = "${aws_cloudfront_distribution.cf_distribution.domain_name}"
}  

output "acme_registration_email" {
  value = "${var.acme_registration_email}"
}

output "certificate_domain" {
  value = "${acme_certificate.certificate.certificate_domain}"
}

output "bucket" {
  value = "${aws_s3_bucket.my_bucket.arn}"
}