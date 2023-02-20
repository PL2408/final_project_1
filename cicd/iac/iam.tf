resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = aws_iam_role.ec2_role.name
}

resource "aws_iam_role" "ec2_role" {
  name = "ec2_role"
  path = "/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "s3_read_policy" {
  name = "ec2-s3Read"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect : "Allow",
        Action : [
          "s3:ListAllMyBuckets",
          "s3:ListBucket",
          "s3:GetBucketLocation"
        ],
        Resource : "*"
      },
      {
        Action   = ["s3:*"]
        Effect   = "Allow"
        Resource = ["arn:aws:s3:::lopihara/*"]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "route53:ChangeResourceRecordSets",
          "route53:ChangeResourceRecordSets"
        ],
        "Resource" : [
          "arn:aws:route53:::hostedzone/Z02078421SPA6MWP3QHES"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:DescribeInstanceAttribute",
          "ec2:DescribeInstanceCreditSpecifications",
          "ec2:DescribeInstanceStatus",
          "ec2:DescribeInstances"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_policy_attachment" {
  policy_arn = aws_iam_policy.s3_read_policy.arn
  role       = aws_iam_role.ec2_role.name
}