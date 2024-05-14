############### BastionHost Role ###############
resource "aws_iam_role" "BastionHost_role" {
    name = var.bastionhostrole
    description = "BastionHost Role"
    assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
    })
    lifecycle {
        # Ignore changes Bastion Role Policy Attachment (UAT need to Attach) 
        ignore_changes = [managed_policy_arns
        ]
    }
    managed_policy_arns = [
        "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
        "arn:aws:iam::aws:policy/AmazonEKSServicePolicy",
        "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM",
        "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy",
        "arn:aws:iam::aws:policy/service-role/AWSQuicksightAthenaAccess",
        aws_iam_policy.S3ManagedPolicy.arn,
        aws_iam_policy.bastionhostmanagedpolicy.arn
    ]
    depends_on = [aws_iam_policy.S3ManagedPolicy, aws_iam_policy.bastionhostmanagedpolicy]
    tags = var.default_tag
}

############## EKS Service Role ###############
resource "aws_iam_role" "EKSService_role" {
    name = var.eksservicerole
    description = "EKS Service Role"
    assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
    })

    managed_policy_arns = [
        "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
        "arn:aws:iam::aws:policy/AmazonEKSServicePolicy",
    ]
    tags = var.default_tag
}
############## WorkerNode Role ###############
resource "aws_iam_role" "WorkerNode_role" {
    name = var.WorkerNoderole
    description = "WorkerNode_role"
    assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
    })

    lifecycle {
    # Ignore chnage add/remove application team manual on console
    ignore_changes = [managed_policy_arns]
    }

    managed_policy_arns = [
        "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
        "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
        "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy",
        "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM",
        "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
        "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy",
        aws_iam_policy.ApplicationAccessPolicy.arn,
        aws_iam_policy.S3ManagedPolicy.arn
    ]
    #depends_on = [aws_iam_policy.S3ManagedPolicy,aws_iam_policy.AmazonSESSendingAccess,aws_iam_policy.SNSAppAccess,aws_iam_policy.SQSAppAccess]
    depends_on = [aws_iam_policy.S3ManagedPolicy,aws_iam_policy.ApplicationAccessPolicy]
    tags = var.default_tag
}
resource "aws_iam_instance_profile" "WorkerNode_role_instance_profile" {
    name = var.WorkerNoderole_instanceprofile
    role = aws_iam_role.WorkerNode_role.name
    depends_on = [aws_iam_role.WorkerNode_role]
    tags = var.default_tag
}

############### Application Policy ###############
## S3, SNS, SES, SQS, KMS
resource "aws_iam_policy" "ApplicationAccessPolicy" {
    name        = var.applicationpolicyname
    path        = "/"
    description = "${var.AppName} Application Policy"
    policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        # {
        #     Action = [
        #     "ses:*"
        #     ]
        #     Effect    = "Allow"
        #     Sid       = "AllowAccessSESApp"
        #     Resource  = "arn:aws:ses:us-east-1:${data.aws_caller_identity.caller_identity_awsappaccount.account_id}:identity/${var.email_app}"
        # },
        #   {
        #     Action = [
        #     "ses:SendRawEmail"
        #     ]
        #     Effect    = "Allow"
        #     Sid       = "AmazonSesSendingAccessApp"
        #     Resource  = "*"
        # },
        # {
        #     Action = [
        #     "sns:*"
        #     ]
        #     Effect    = "Allow"
        #     Sid       = "AllowAccessSNSApp"
        #     Resource  = "*"
        # },        
        {
            Action = [
            "sqs:*"
            ]
            Effect    = "Allow"
            Sid       = "AllowAccessSQSApp"
            Resource  = "*"
        }         
        ]
    })
    tags = var.default_tag
}

############### S3 Management Policy ###############
resource "aws_iam_policy" "S3ManagedPolicy" {
    name        = var.s3managedpolicyname
    path        = "/"
    description = "S3 policy"
    policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*",
        ]
        Effect   = "Allow"
        Resource  = [
            "arn:aws:s3:::${var.bucketS3}",
            "arn:aws:s3:::${var.bucketS3}/*",
            "arn:aws:s3:::${var.bucketJenkins}",
            "arn:aws:s3:::${var.bucketJenkins}/*",
        ]
      },
      # {
      #   Action = [
      #     "s3:*",
      #   ]
      #   Effect   = "Allow"
      #   Resource  = [
      #       "arn:aws:s3:::${var.bucketS3_cdn_orbix}" ,
      #       "arn:aws:s3:::${var.bucketS3_cdn_orbix}/*",
      #       "arn:aws:s3:::${var.bucketS3_cdn_in_quarix}" ,
      #       "arn:aws:s3:::${var.bucketS3_cdn_in_quarix}/*",
      #       "arn:aws:s3:::${var.bucketS3_cdn_in_orbix}" ,
      #       "arn:aws:s3:::${var.bucketS3_cdn_in_orbix}/*" 
      #   ]
      # },
    ]
    })
    # depends_on = [aws_s3_bucket.bucketS3_main, aws_s3_bucket.jenkinsbucketS3_main]
    tags = var.default_tag
}

############### Bastionhost Policy ###############
resource "aws_iam_policy" "bastionhostmanagedpolicy" {
    name        = var.bastionhostpolicyname
    path        = "/"
    description = "Policy for EKS bastion host"
    policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            Action = [
            "eks:*",
            "cloudformation:CreateStack",
            "cloudformation:UpdateStack",
            "iam:PassRole"
            ]
            Effect    = "Allow"
            Sid       = "VisualEditor0"
            Resource  = "*"
        },
        {
            Action = [
            "quicksight:RegisterUser",
            "quicksight:CreateDataSet",
            "quicksight:DescribeDataSet",
            "quicksight:UpdateDataSet",
            "quicksight:UpdateDataSetPermissions",
            "quicksight:CreateAnalysis",
            "quicksight:DescribeAnalysis",
            "quicksight:UpdateAnalysis",
            "quicksight:UpdateAnalysisPermissions",
            "quicksight:CreateTemplate",
            "quicksight:DescribeTemplate",
            "quicksight:UpdateTemplate",
            "quicksight:UpdateTemplatePermissions",
            "quicksight:CreateDashboard",
            "quicksight:DescribeDashboard",
            "quicksight:UpdateDashboard",
            "quicksight:UpdateDashboardPermissions",
            ]
            Effect    = "Allow"
            Sid       = "AllowAccessQuickSight"
            Resource  = "*"
        },
        ]
    })
    tags = var.default_tag
}

############### Attachment BastionHost Policy to Role ###############
resource "aws_iam_policy_attachment" "bastionhost-attach" {
  name       = "${var.AppName}-bastionhost-policy-attachment-bastionhost-role"
  roles      = [aws_iam_role.BastionHost_role.name]
  depends_on = [aws_iam_role.BastionHost_role]
  policy_arn = aws_iam_policy.bastionhostmanagedpolicy.arn
}

############### Instance Profile ###############
resource "aws_iam_instance_profile" "iam_profile_bastionhost" {
  name = "${var.AppName}${var.Env}EC2BastionHostInstanceProfile"
  role = aws_iam_role.BastionHost_role.name
  depends_on = [aws_iam_role.BastionHost_role]
  tags = var.default_tag
}



############ Output Part ############
# output "EKSService_Role"{
#   description = "Arn of EKSService Role"
#   value       = try(aws_iam_role.EKSService_role.arn, "")
# }
output "BastionHost_Role"{
  description = "Arn of BastionHost Role"
  value       = try(aws_iam_role.BastionHost_role.arn, "")
}
output "BastionHost_Role_Name"{
  description = "Arn of BastionHost Role"
  value       = try(aws_iam_role.BastionHost_role.name, "")
}
output "BastionHost_Policy"{
  description = "Arn of BastionHost Policy"
  value       = try(aws_iam_policy.bastionhostmanagedpolicy.arn, "")
}
output "Instance_Profile"{
  description = "Arn of BastionHost Instance Profile"
  value       = try(aws_iam_instance_profile.iam_profile_bastionhost.arn, "")
}
# output "WorkerNode_role"{
#   description = "Arn of PodExecution Role"
#   value       = try(aws_iam_role.WorkerNode_role.arn, "")
# }
# output "S3_Policy"{
#   description = "Arn of S3 Policy"
#   value       = try(aws_iam_policy.S3ManagedPolicy.arn, "")
# }

# output "Instance_Profile_Workernode_Arn"{
#   description = "Arn of Workernode Instance Profile"
#   value       = try(aws_iam_instance_profile.WorkerNode_role_instance_profile.arn, "")
# }
