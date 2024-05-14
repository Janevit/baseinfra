# AWS Key Management Service (AWS KMS)
A managed service that makes it easy for you to create and control the cryptographic keys that are used to protect your data.
* **Symmetric encryption** uses a single key for both encryption and decryption. The shared key must be sent together with the encrypted data in order for other parties to read it.
* **Asymmetric encryption** uses a mathematically related public and private key for encryption and decryption. The public key is used for encrypting data and can never be used for decryption. The private key is only used for decrypting data.

----
## Diagram
![alt text](KBTG-Terraform-diagram-6.KMS.drawio.png)
----
## Resources pipeline (need to deploy this.)
No prerequisite resources. 

----
## Remark
* you can add reference arn resource or arn IAM Role or arn of IAM user for **"Allow access for Key User"** at **line 52** (identifiers[]) in KMS.tf file.

```tf
    principals {
      type = "AWS"
      identifiers = [
         aws_iam_role.WorkerNode_role.arn,  ## Worker Role Node ARN
         ARN of IAM user,
         ARN of IAM Role
      ]
    }
```

* you can add reference arn resource or arn IAM Role or arn of IAM user for **"Allow access for Key Administrators"** at **line 99** (identifiers[]) in KMS.tf file.

```tf
    principals {
      type = "AWS"
      identifiers = [
         aws_iam_role.WorkerNode_role.arn,  ## Worker Role Node ARN
         ARN of IAM user,
         ARN of IAM Role
      ]
    }
```


----
## Input Variable
Variable | Detail | Example |
----- | ----- | ----- |
aliaskms | alias of symmetric KMS type for Application | **AppName**-Symmetric-**Env** |
aliaskms_asymmetric | alias of asymmetric KMS key for Application | **AppName**-Asymmetric-**Env** |

----
## Output Variable
Variable | Detail | Example |
----- | ----- | ----- |
kms_arn | arn of symmetric KMS type for Application | arn:aws:kms:**region**:**AccountID**:key/**ID** |
kms_arn_asymmetric | arn of asymmetric KMS key for Application | arn:aws:kms:**region**:**AccountID**:key/**ID** |

----
### Reference terraform resource
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias