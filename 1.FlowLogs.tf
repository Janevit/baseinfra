resource "aws_cloudwatch_log_group" "flowlog_log_group" {
  name = "${var.AppName}-flowlogs"
  retention_in_days     =   lower(var.Env) == "prod" ? 30 : 3 
}

resource "aws_iam_role" "flowlog_IAMRole" {
  name               = "${var.AppName}-flowlogs-Role"
  assume_role_policy = data.aws_iam_policy_document.data_flowlog_role.json
}

data "aws_iam_policy_document" "data_flowlog_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy" "flowlog_policy" {
  name          = "${var.AppName}-flowlogs-Policy"
  role          = aws_iam_role.flowlog_IAMRole.id
  policy        = data.aws_iam_policy_document.data_flowlog_policy.json
  depends_on    = [aws_iam_role.flowlog_IAMRole]
}

data "aws_iam_policy_document" "data_flowlog_policy" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
    ]

    resources = ["*"]
  }
}

resource "aws_flow_log" "flowlog_main" {
  vpc_id                    =   aws_vpc.vpc_main.id
  iam_role_arn              =   aws_iam_role.flowlog_IAMRole.arn
  log_destination           =   aws_cloudwatch_log_group.flowlog_log_group.arn
  traffic_type              =   "ALL"
  max_aggregation_interval  =   60
  log_destination_type      =   "cloud-watch-logs"
  depends_on                =   [aws_vpc.vpc_main, aws_iam_role.flowlog_IAMRole, aws_cloudwatch_log_group.flowlog_log_group]
}