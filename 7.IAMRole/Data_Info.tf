data "aws_caller_identity" "caller_identity_awsappaccount" {
    provider = aws
}

data "aws_caller_identity" "caller_identity_shareinfra" {
    provider = aws.ShareInfra
}