# create ci/cd user with access keys (for build system)
resource "aws_iam_user" "cicd" {
  name = "devOps_${var.app}_cicd"
}

resource "aws_iam_access_key" "cicd_keys" {
  user = aws_iam_user.cicd.name
}

# grant required permissions to deploy
data "aws_iam_policy_document" "cicd_policy" {

  statement {
    sid = "S3Read"

    actions = [
      "s3:ListBucket",
    ]

    resources = [
        "${aws_s3_bucket.my_bucket.arn}",
    ]
  }

  statement {
    sid = "S3Write"

    actions = [
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject"
    ]

    resources = [
      "${aws_s3_bucket.my_bucket.arn}/*",
    ]
  }

}

resource "aws_iam_user_policy" "cicd_user_policy" {
  name   = "devOps_${var.app}_cicd"
  user   = aws_iam_user.cicd.name
  policy = data.aws_iam_policy_document.cicd_policy.json
}

# The AWS keys for the CICD user to use in a build system
output "cicd_keys" {
  value = "terraform show -json | jq '.values.root_module.resources | .[] | select ( .address == \"aws_iam_access_key.cicd_keys\") | { AWS_ACCESS_KEY_ID: .values.id, AWS_SECRET_ACCESS_KEY: .values.secret }'"
}