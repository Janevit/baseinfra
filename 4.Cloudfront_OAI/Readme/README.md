# Cloudfront OAI (Origin Access Identity)
A feature of Amazon Cloudfront, a content delivery network (CDN) provided by AWS. Cloudfront OAI allows you to control access to your content by creating a special CloudFront user identity that is used to authenticate requests between CloudFront and your origin server (e.g., an Amazon S3 bucket or EC2 instance).

When you associate an OAI with your CloudFront distribution, it generates a unique CloudFront user identity. You can configure your origin server to only allow requests from this CloudFront user identity. This helps in securing your content, as requests directly to your origin server will be rejected unless they come through CloudFront with the appropriate authentication.

----
## Diagram
![alt text](KBTG-Terraform-diagram-4.Cloudfront_OAI.drawio.png)
----
## Resources pipeline (need to deploy this.)
No prerequisite resources. 

----
## Remark
 --
----
## Input Variable
No input variable.

----
## Output Variable
Variable | Detail | Example |
----- | ----- | ----- |
OAI-IAM | IAM arn of Origin Access Identity | arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity **ID** |
OAI-path | access identity path of OAI | origin-access-identity/cloudfront/**ID** |

----
### Reference terraform resource
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_identity