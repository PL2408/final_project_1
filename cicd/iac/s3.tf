resource "aws_s3_bucket" "sp_bucket" {
  bucket = "web2.lopihara"

  tags = {
    Name = "web2.lopihara"
  }
}

resource "aws_s3_bucket_policy" "bucket_policy_for_cf" {
  bucket = aws_s3_bucket.sp_bucket.id
  policy = data.aws_iam_policy_document.read_cf_bucket_policy.json
}

data "aws_iam_policy_document" "read_cf_bucket_policy" {
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.sp_bucket.arn}/*"]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.s3_distribution.arn]
    }
  }
}