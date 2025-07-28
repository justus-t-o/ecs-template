resource "aws_iam_user" "grafana_cloud" {
  name = "grafana-cloud-read-only"
}

resource "aws_iam_policy" "grafana_cloud_readonly" {
  name        = "grafana-cloud-readonly"
  description = "Read-only access to CloudWatch metrics and logs for Grafana Cloud"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "cloudwatch:GetMetricData",
          "cloudwatch:ListMetrics",
          "cloudwatch:GetMetricStatistics",
          "logs:DescribeLogGroups",
          "logs:FilterLogEvents"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "attach" {
  user       = aws_iam_user.grafana_cloud.name
  policy_arn = aws_iam_policy.grafana_cloud_readonly.arn
}

resource "aws_iam_access_key" "grafana_cloud_key" {
  user = aws_iam_user.grafana_cloud.name
}
