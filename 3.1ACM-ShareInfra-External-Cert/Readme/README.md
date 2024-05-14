# AWS Certificate Manager (ACM)
A service that lets you easily provision, manage, and deploy public and private Secure Sockets Layer/Transport Layer Security (SSL/TLS) certificates for use with AWS services and your internal connected resources.

---- 
## Diagram
![alt text](KBTG-Terraform-diagram-3.1ACM-ShareInfra-External-Cert.drawio.png)
----
## Resources pipeline (need to deploy this.)
No prerequisite resources. 

----
## Remark
* this service for create ACM on shareinfra-nonprod(Prod) Account and in Singapore and Virginia region.
* if you have many certificate, you can duplicate resource and change name of resource for created more ACM on AWS.
* after SAM team create certificate completed, you will receive 3 files name:
  1. Entrust Root Certification Authority - G2.crt: root file
  2. Entrust Certification Authority - L1K.crt: intermediate file
  3. (domain).crt: body file
  in case to create ACM by terraform cloud, we need to use 3 files (create new file for this case and copy information from 3 files that receive from SAM team)
  1. Private Key file: use your own private key that use to generate CSR for SAM team
  2. Body file: use (domain).crt
  3. Chain file: use 3 files sort by Entrust Root Certification Authority - G2.crt, Entrust Certification Authority - L1K.crt, and (domain).crt respectively
* you need to place 3 files in the same location with ACM-ShareInfra-External-Cert.tf or move 3 files to folder that same location with ACM-ShareInfra-External-Cert.tf

----
## Input Variable
Variable | Detail | Example |
----- | ----- | ----- |
ACM_private_key_shareinfra | path of private key file for certificate manager | **"(foldername)/(filename)"** or **"(filename)"** |
ACM_cert_body_shareinfra | path of body file for certificate manager | **"(foldername)/(filename)"** or **"(filename)"** |
ACM_cert_chain_shareinfra | path of chain file for certificate manager | **"(foldername)/(filename)"** or **"(filename)"** | 

----
## Output Variable
Variable | Detail | Example |
----- | ----- | ----- |
Certificate_Nonprod_Singapore_Arn | ACM Certificate (Nonprod-Singapore Account) Arn | arn:aws:acm:**region**: **AccountID**:certificate/**ID** |

----
### Reference terraform resource
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate