# KBTG BaseInfra

BaseInfra is a base network resource and connectivity resource following on organization solution architecture. Consists of 

1. **VPC**: CIDR Block and Secondary CIDR Block.

2. **Subnet**: Public Subnet, Private Subnet and Database Subnet. Created on avability zone (2 Zone AZa,AZb or 3 Zone AZa,AZb,AZc) depend on parameter flag **Enable_3_AvailabilityZone**.

3. **Routable (RT)**: Routable associate in each subnet and basic rule. 

4. **Internet Gateway(IGW)**: A VPC component that allows communication between your VPC and the internet. **Solution architecture by default will not be created, traffic will go in-out via ShareInfra on Transit Gateway**

5. **NAT Gateway(NATGW)**: Service that connect to the Internet from instances within a private subnet in VPC. **Solution architecture by default will not be created, traffic outbound will go out via ShareInfra on Transit Gateway**

6. **Transit Gateway Attachment(TGW Att)**: the connection between resources like VPC, VPN, Direct Connect, and the TGW (Private Subnet outbound connection will go out via TGW).

7. **Peering** to other VPC necessary services : A connection between Application and VPC services such as Devops VPC, VA Scan VPC, Security VPC.

8. **Connectivity to ShareInfra Service**: --

9. **Keypair**: basic keypair for Bastion Host , EKS Workernode and other VM services (you can create new for dedicate on each VM service)

---- 
## Prerequisite
* **IP Address Range (Contact Infra Team)**
    * For 2 and 3 Availability Zone need subnet /24

* **Sharing Reources from other account** 
    * Case: new account
        - Share TGW from ShareInfra : (Contact Kinfra CCoE Team)
        - Share AMI Golden Image from Security Account (Contact Kinfra CCoE Team)

    * Case: existing account (Before Deploy Terrafom)
        
        **For Non Production**
        - Open basic Infra Firewall Rule (Folder: Preriqusite Document/NonProd_Basic_Infra_Firewall_Rule_Tufin.xlsx)
        
        **For Production**
        - Open basic Infra Firewall Rule (Folder: Preriqusite Document/Prod_Basic_Infra_Firewall_Rule_Tufin.xlsx)
 
## Post-Process
--

----
## Diagram
BaseInfra 2 Avability Zone

*For 2 Availability Zone need subnet /24
![alt text](KBTG-Terraform-diagram-1.Base_Infra.tf_(2AZ).drawio.png)

BaseInfra 3 Avability Zone

*For 3 Availability Zone need subnet /24
![alt text](KBTG-Terraform-diagram-1.Base_Infra.tf_(3AZ).drawio.png)

----
## Resources pipeline (need to deploy this.)
No prerequisite resources. 

----
## Remark
* **Emergency Case**: bypassing traffic route via ShareInfra, terraform will create Application Internet Gateway of VPC and NATGW at private subnet and change routing follow this
    
    * Public Subnet: default route to IGW.
    * Private SubnetL default route to Application NATGW

    File: env.auto.tfvars

    ```tf
    # IGW, NATGW
    Enable_IGW_NATGW                    = false -> true
    # Default Route Option
    Default_Route_NATGW_InternetGW      = false -> true
    ```
    ![alt text](KBTG-Terraform-diagram-1.Base_Infra.tf_(2AZ)_bypass.drawio.png)

----
## Input Variable
Variable | Detail | Example |
----- | ----- | ----- |
Enable_3_AvailabilityZone | Enable 3 AvailabilityZone (AZa,AZb,AZc) | true |
VPCCIDRParameter | Application Network CIDR <br/>    * For 2 Availability Zone need subnet /24 <br/>* For 3 Availability Zone need subnet /24 | 10.42.xx.0/24 (Contact Infra Team)|
VPCSecondaryCIDRParameter | Secondary CIDR for Kubnernetes workernode pod deployment | 100.xx.0.0/16 (Contact Infra Team) |
PublicSubnetAZaParameter | Public Subnet AZa | 10.42.xx.xx/27 |
PublicSubnetAZbParameter | Public Subnet AZb | 10.42.xx.xx/27 |
PublicSubnetAZcParameter | Public Subnet AZc (if Enable 3 AvailabilityZone) | 10.42.xx.xx/27 |
PrivateSubnetAZaParameter | Private Subnet AZa | 10.42.xx.xx/27 |
PrivateSubnetAZbParameter | Private Subnet AZb | 10.42.xx.xx/27 |
PrivateSubnetAZcParameter | Private Subnet AZc (if Enable 3 AvailabilityZone) | 10.42.xx.xx/27 |
DatabaseSubnetAZaParameter | Database Subnet AZa | 10.42.xx.xx/27 |
DatabaseSubnetAZbParameter | Database Subnet AZb | 10.42.xx.xx/27 |
DatabaseSubnetAZcParameter | Database Subnet AZc (if Enable 3 AvailabilityZone) | 10.42.xx.xx/27 |
SecondarySubnetAZaParameter | Secondary Subnet AZa | 100.xx.xx.0/1x |
SecondarySubnetAZbParameter | Secondary Subnet AZb | 100.xx.xx.0/1x |
SecondarySubnetAZcParameter | Secondary Subnet AZc (if Enable 3 AvailabilityZone) | 100.xx.xx.0/1x |
Enable_key_pair | Enable create Keypair | true |
key_name | Name of keypair | **AppName**-Key |
EKS_Tag_Public_Subnet | Public Subnet tag for EKS Service | {<br>"kubernetes.io/cluster/**AppName**-EKS-Cluster" = "shared"<br>"kubernetes.io/role/elb " = 1<br>} |
EKS_Tag_Private_Subnet | Private Subnet tag for EKS Service |{<br>"kubernetes.io/cluster/**AppName**-EKS-Cluster" = "shared"<br>"kubernetes.io/role/internal-elb " = 1<br>} |
EKS_Tag_Database_Subnet | Database Subnet tag for EKS Service |{<br>"kubernetes.io/cluster/**AppName**-EKS-Cluster" = "shared"<br>} |

----
## Output Variable
Variable | Detail | Example |
----- | ----- | ----- |
vpc_id | ID of the VPC | Example |
PublicSubnetAZa_id | ID of the PublicSubnetAZa | Example |
PublicSubnetAZb_id | ID of the PublicSubnetAZb | Example |
PublicSubnetAZc_id | ID of the PublicSubnetAZc | Example |
PrivateSubnetAZa_id | ID of the PrivateSubnetAZa | Example |
PrivateSubnetAZb_id | ID of the PrivateSubnetAZb | Example |
PrivateSubnetAZc_id | ID of the PrivateSubnetAZc | Example |
DatabaseSubnetAZa_id | ID of the DatabaseSubnetAZa | Example |
DatabaseSubnetAZb_id | ID of the DatabaseSubnetAZb | Example |
DatabaseSubnetAZc_id | ID of the DatabaseSubnetAZc | Example |
SecondarySubnetAZa_id | ID of the SecondarySubnetAZa | Example |
SecondarySubnetAZb_id | ID of the SecondarySubnetAZb | Example |
SecondarySubnetAZc_id | ID of the SecondarySubnetAZc | Example |
VPCIGW_id | ID of the VPCIGW_id | Example |
VPCAZaEIP_id | ID of the VPCAZaEIP_id | Example |
VPCAZaEIP-IP | ID of the VPCAZaEIP | Example |
VPCAZaNGW_id | ID of the VPCAZaNGW_id | Example |
IGW_VPCRT_id | ID of the IGW_VPCRT_id | Example |
PublicRT_AZa_id | ID of the PublicRT_AZa_id | Example |
PrivateRT_AZa_id | ID of the PrivateRT_AZa_id | Example |
PublicRT_AZb_id | ID of the PublicRT_AZb_id | Example |
PrivateRT_AZb_id | ID of the PrivateRT_AZb_id | Example |
PublicRT_AZc_id | ID of the PublicRT_AZc_id | Example |
PrivateRT_AZc_id | ID of the PrivateRT_AZc_id | Example |
TGW_Internal_App_Att | ID of the TGW_Internal_App_Att | Example |
Peering_App_to_DevOps | ID of Peering_App_to_DevOps | Example |
Peering_App_to_DevOps_Status | Status of Peering_App_to_DevOps | Example |
tls_key_pair| Private Key of Keypair | **See at State File** |
key_pair| Keypair Name | Example |

----
### Reference terraform resource
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_transit_gateway_attachment