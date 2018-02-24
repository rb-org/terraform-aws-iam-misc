output "secret" {
  value = "${aws_iam_access_key.access_key.secret}"
}

output "id" {
  value = "${aws_iam_access_key.access_key.id}"
}
