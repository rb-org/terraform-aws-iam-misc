resource "aws_iam_user" "user" {
  name = "${var.username}"
}

resource "aws_iam_access_key" "access_key" {
  user = "${aws_iam_user.user.name}"
}

resource "aws_iam_user_policy" "user_policy" {
  name = "${var.name_prefix}-${var.username}_user_role"
  user = "${aws_iam_user.user.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
