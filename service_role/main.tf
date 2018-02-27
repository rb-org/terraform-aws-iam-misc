data "aws_iam_policy_document" "main_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "${var.principal_type}"
      identifiers = ["${var.principal_identifiers}"]
    }
  }
}

resource "aws_iam_role" "main_role" {
  name               = "${var.name}"
  path               = "/"
  assume_role_policy = "${data.aws_iam_policy_document.main_assume_role_policy.json}"
}

resource "aws_iam_role_policy_attachment" "main_role_policy_attachment" {
  count      = "${length(compact(var.managed_policy_arns))}"
  role       = "${aws_iam_role.main_role.name}"
  policy_arn = "${var.managed_policy_arns[count.index]}"
}
