resource "aws_iam_user" "admin_user" {
    name = "Shivam"
    tags = {
      Description = "DevOps Intern"
    }
}

resource "aws_iam_policy" "admin_policy" {
    name = "Admin-Policy"
    policy = file(admin_policy.json)
}

resource "aws_iam_user_policy_attachment" "admin_attachment" {
    user       = aws_iam_user.admin_user.name
    policy_arn = aws_iam_policy.admin_policy.arn
}