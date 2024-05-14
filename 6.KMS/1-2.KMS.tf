resource "aws_kms_key" "kms_main" {
  description              = "key management services for App"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  is_enabled               = true
  enable_key_rotation      = true
  policy                   = data.aws_iam_policy_document.policy_permission.json
  # depends_on               = [aws_iam_role.BastionHost_role, aws_iam_role.EKSService_role]
  tags                     = var.default_tag
}

resource "aws_kms_alias" "kmsalias" {
  name                     = "alias/${var.aliaskms}"
  target_key_id            = aws_kms_key.kms_main.key_id
  depends_on               = [aws_kms_key.kms_main]
}

resource "aws_kms_key" "kms_main_asymmetric" {
  description              = "key management services for App asymmetric key"
  customer_master_key_spec = "RSA_2048"
  is_enabled               = true
  # enable_key_rotation      = true  # Not Support Auto rotation key
  policy                   = data.aws_iam_policy_document.policy_permission.json
  # depends_on               = [aws_iam_role.BastionHost_role, aws_iam_role.EKSService_role]
  tags                     = var.default_tag
}

resource "aws_kms_alias" "kmsalias_asymmetric" {
  name                     = "alias/${var.aliaskms_asymmetric}"
  target_key_id            = aws_kms_key.kms_main_asymmetric.key_id
  depends_on               = [aws_kms_key.kms_main_asymmetric]
}


data "aws_iam_policy_document" "policy_permission" {
  statement {
    sid = "Allow access for Key User"
    effect = "Allow"
    actions = [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:DescribeKey",
        "kms:CreateGrant",
        "kms:GetPublicKey"
    ]
    resources = [
      "*",
    ]
    principals {
      type = "AWS"
      identifiers = [
         aws_iam_role.WorkerNode_role.arn,
         
      ]
    }
  }

  statement {
    sid = "Enable IAM User Permissions"
    effect = "Allow"
    actions = [
        "kms:*"
    ]
    resources = [
      "*",
    ]
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.caller_identity_awsappaccount.account_id}:root",
      ]
    }
  }

  statement {
    sid = "Allow access for Key Administrators"
    effect = "Allow"
    actions = [
        "kms:Create*",
        "kms:Describe*",
        "kms:Enable*",
        "kms:List*",
        "kms:Put*",
        "kms:Update*",
        "kms:Revoke*",
        "kms:Disable*",
        "kms:Get*",
        "kms:Delete*",
        "kms:TagResource",
        "kms:UntagResource",
        "kms:ScheduleKeyDeletion",
        "kms:CancelKeyDeletion",
        "kms:CreateGrant",
        "kms:GetPublicKey"
    ]
    resources = [
      "*",
    ]
    principals {
      type = "AWS"
      identifiers = [
        aws_iam_role.WorkerNode_role.arn
      ]
    }
  }
  depends_on  = [aws_iam_role.WorkerNode_role]
}

############ Output Part ############
output "kms_arn"{
  description = "Arn of kms"
  value       = try(aws_kms_key.kms_main.arn)
}
output "kms_arn_asymmetric"{
  description = "Arn of kms"
  value       = try(aws_kms_key.kms_main_asymmetric.arn)
}
