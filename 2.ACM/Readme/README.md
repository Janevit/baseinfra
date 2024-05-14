# AWS Certificate Manager (ACM)
    This service is for enterprise customers who need a secure web presence using TLS. ACM certificates are deployed through Elastic Load Balancing, Amazon CloudFront, Amazon API Gateway, and other integrated AWS services.

----
## Diagram
![alt text](KBTG-Terraform-diagram-2.ACM.drawio.png)

----
## Resources pipeline (need to deploy this.)
No prerequisite resources. 

----
## Remark
* if you have many certificate, you can duplicate resource and change name of resource for created more ACM on AWS.

----
## Input Variable
Variable | Detail | Example |
----- | ----- | ----- |
Amazon_issued_certificate_1 | email application in singapore region on aws | xxx.com |

----
## Output Variable
Variable | Detail | Example |
----- | ----- | ----- |
Certificate_Amazon_issued_certificate_1_Arn | ACM Certificate Arn | arn:aws:acm:**region**: **AccountID**:certificate/**ID** |

----
### Reference terraform resource
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate