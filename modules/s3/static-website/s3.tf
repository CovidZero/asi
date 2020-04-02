resource "aws_s3_bucket" "default" {
  bucket = "${var.name}.${var.base_domain}"
  policy = data.aws_iam_policy_document.bucket_sourceip_policy.json

  website {
    index_document = "index.html"
  }

  versioning {
    enabled = var.versioning_enabled
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

data "aws_iam_policy_document" "bucket_sourceip_policy" {
  statement {
    actions = [
      "s3:GetObject"
    ]

    resources = [
      "arn:aws:s3:::${var.name}.${var.base_domain}/*"
    ]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"
      values   = var.sourceIps
    }
  }
}
