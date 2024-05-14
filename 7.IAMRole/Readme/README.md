# Resource Name

**IAM Role**

An IAM role is an identity within your AWS account that has specific permissions. It is similar to an IAM user, but is not associated with a specific person.

**IAM policies**

IAM policies define permissions for an action regardless of the method that you use to perform the operation. For example, if a policy allows the GetUser action, then a user with that policy can get user information from the AWS Management Console, the AWS CLI, or the AWS API.

----
## Diagram
![alt text](KBTG-Terraform-diagram-7.IAMRole.drawio.png)
----
## Resources pipeline (need to deploy this.)
No prerequisite resources. 

----
## Remark
 * **resource "aws_iam_role" "EKSService_role"** and **resource "aws_iam_role" "WorkerNode_role"** can remove, if not using EKS (EKS Cluster and EKS Workernode)

 * At **resource "aws_iam_policy" "ApplicationAccessPolicy"** block , Application team  can define own application's resource permission.

    ``` tf
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
                  {
            Action = [
            "s3:*",
            ]
            Effect   = "Allow"
            Sid       = "S3AccessApp"
            Resource  = [
                "arn:aws:s3:::${var.bucketS3}",
                "arn:aws:s3:::${var.bucketS3}/*"
            ]
            },      
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
    ```

----
## Input Variable
Variable | Detail | Example |
----- | ----- | ----- |
eksservicerole | iam role for EKS service use with kms | **AppName**-**Env**-EKS-Service-Role |
bastionhostrole | iam role of EC2 bastion host use with kms | **AppName**-**Env**-EC2-BastionHost-Role |
applicationpolicyname | name of application Policy | **AppName**-**Env**-App-Policy |
s3managedpolicyname | name of S3 Managed Policy | **AppName**-**Env**-S3-Policy |
bastionhostpolicyname | name of Bastionhost Managed Policy | **AppName**-**Env**-BastionHost-Managed-Policy |
bucketS3 | name of S3 for application bucket | **application id**-**AppName**-**Env**-bucket <br/> Ex: 804-EVBikes-uat-bucket|
bucketJenkins | name of S3 for jenkins bucket | **application id**-**AppName**-**Env**-jenkins-bucket <br/> Ex: 804-EVBikes-uat-jenkins-bucket|

----
## Output Variable
Variable | Detail | Example |
----- | ----- | ----- |
BastionHost_Role | Arn of BastionHost Role | arn:aws:iam::**AccountID**:role/**AppName**-**Env**-EC2-BastionHost-Role |
BastionHost_Role_Name | Arn of BastionHost Role | **AppName**-**Env**-EC2-BastionHost-Role |
BastionHost_Policy | Arn of BastionHost Policy | arn:aws:iam::**AccountID**:policy/**AppName**-**Env**-BastionHost-Managed-Policy |
Instance_Profile | Arn of BastionHost Instance Profile | arn:aws:iam::**AccountID**:instance-profile/**AppNameEnv**EC2BastionHostInstanceProfile |

----
### Reference terraform resource
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role