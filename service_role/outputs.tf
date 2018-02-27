output "lambda_role_name" {
  value = "${aws_iam_role.lambda_role.name}"
}

output "lambda_role_id" {
  value = "${aws_iam_role.lambda_role.id}"
}
