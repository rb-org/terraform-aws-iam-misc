data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "instance_role" {
  name               = "${var.name}"
  path               = "/"
  assume_role_policy = "${data.aws_iam_policy_document.instance_assume_role_policy.json}"
}

resource "aws_iam_instance_profile" "instance_role_instance_profile" {
  name = "${var.name}-profile"
  role = "${aws_iam_role.instance_role.name}"
}

resource "aws_iam_role_policy_attachment" "instance_role_policy_attachment" {
  count      = "${length(compact(var.managed_policy_arns))}"
  role       = "${aws_iam_role.instance_role.name}"
  policy_arn = "${var.managed_policy_arns[count.index]}"
}

// Cloudwatch logging
resource "aws_iam_policy" "cw_logs" {
  name        = "${var.name}-cw-logs-policy"
  path        = "/"
  description = "Allow write to CW logs"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "CloudWatchAgentServerPolicy",
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "cloudwatch:PutMetricData",
                "ec2:DescribeTags",
                "logs:DescribeLogStreams",
                "logs:CreateLogGroup",
                "logs:PutLogEvents",
                "ssm:GetParameter"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "cw_logs_attach" {
  role       = "${aws_iam_role.instance_role.name}"
  policy_arn = "${aws_iam_policy.cw_logs.arn}"
}
