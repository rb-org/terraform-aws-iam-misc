output "main_role_name" {
  value = "${aws_iam_role.main_role.name}"
}

output "main_role_id" {
  value = "${aws_iam_role.main_role.id}"
}
