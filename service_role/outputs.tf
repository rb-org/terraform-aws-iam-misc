output "role_name" {
  value = "${aws_iam_role.main_role.name}"
}

output "role_id" {
  value = "${aws_iam_role.main_role.id}"
}

output "role_arn" {
  value = "${aws_iam_role.main_role.arn}"
}