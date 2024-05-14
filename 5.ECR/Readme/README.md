# ECR (Elastic Container Registry Repository)
    fully-managed container registry service provided by Amazon Web Services (AWS). It is designed to store, manage, and deploy Docker container images.

----
## Diagram
![alt text](KBTG-Terraform-diagram-5.ECR.drawio.png)
----
## Resources pipeline (need to deploy this.)
No prerequisite resources. 

----
## Remark
 --
----
## Input Variable
Variable | Detail | Example |
----- | ----- | ----- |
ecrname | name of ECR repository for project | **AppName**-**Env**-repo |

----
## Output Variable
Variable | Detail | Example |
----- | ----- | ----- |
ecr_uri | URI of the ECR repository | **AccountID**.dkr.ecr.**region**.amazonaws.com/**ecrname** |

----
### Reference terraform resource
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository