####type:string,number,list(string),map(tag)

############### Provider ShareInfra #########
variable "AWS_ACCESS_KEY_ID_SHAREINFRANONPROD" {}
variable "AWS_SECRET_ACCESS_KEY_SHAREINFRANONPROD" {}
variable "AWS_ACCESS_KEY_ID_SECURITYNONPROD" {}
variable "AWS_SECRET_ACCESS_KEY_SECURITYNONPROD" {}
############### Tags ###############
variable "default_tag" {
    type    =   map
    description = "A list of tag for the projects"
    default = {
        "environment"             =   "non-production"
        "budget code"             =   "9999999"
        "application id"          =   "999"
        "application acronym"     =   "999_XXXXX"
        "project"                 =   "XXXXX"   
    }   
}

############### Application Name ###############
variable "AppName" {
    type = string
    description = "name of project"
    default = "AppName"
}

variable "AppID" {
    type = string
    description = "Application ID"
    default = "xxx.xx"
}

variable "Share_Env" {
    type = string
    description = "type of environment"
    default = "nonprod"
}

variable "Env" {
    type = string
    description = "type of environment"
    default = "nonprod"
}

variable "AccountName" {
    type = string
    description = "AccountName"
    default = "xxx.xx"
}

############### Parameter on Share-infra-nonprod account ###############
variable "VPC_ShareInfra" {
    type = string
    description = "vpc KBTG inbound on shareinfra nonprod account"
    default = "vpc-016e5cc43e4be8fe8"
}

variable "Subnet_ShareInfra_AZ1" {
    type = string
    description = "subnet on shareinfra public az1 in shareinfra-nonprod account"
    default = "subnet-0d7e222b5296acbce"
}

variable "Subnet_ShareInfra_AZ2" {
    type = string
    description = "subnet on shareinfra public az2 in shareinfra-nonprod account"
    default = "subnet-05f2572a9800b0fe6"
}

### VPC.tf
############### VPC Parameter ############### 
variable "Enable_3_AvailabilityZone" {
    type = bool
    description = "Enable create subnet 3 Availability Zone"
    default = false
}

variable "VPCCIDRParameter" {
    type = string
    description = "CIDR Block of the VPC"
    default = "xx.xx.xx.xx/xx"
}

variable "VPCSecondaryCIDRParameter" {
    type = string
    description = "Secondary CIDR Block of the VPC"
    default = "xx.xx.xx.xx/xx"
}

############## VPC Subnet Parameter ##############
variable "PublicSubnetAZaParameter" {
    type = string
    description = "CIDR block of the VPC public subnet in AZ-a"
    default = "xx.xx.xx.xx/xx" 
}
variable "PublicSubnetAZbParameter" {
    type = string
    description = "CIDR block of the VPC public subnet in AZ-b"
    default = "xx.xx.xx.xx/xx"
}
variable "PublicSubnetAZcParameter" {
    type = string
    description = "CIDR block of the VPC public subnet in AZ-c"
    default = "xx.xx.xx.xx/xx"
}

variable "PrivateSubnetAZaParameter" {
    type = string
    description = "CIDR block of the VPC private subnet in AZ-a"
    default = "xx.xx.xx.xx/xx"
}
variable "PrivateSubnetAZbParameter" {
    type = string
    description = "CIDR block of the VPC private subnet in AZ-b"
    default = "xx.xx.xx.xx/xx"
}
variable "PrivateSubnetAZcParameter" {
    type = string
    description = "CIDR block of the VPC private subnet in AZ-c"
    default = "xx.xx.xx.xx/xx"
}

variable "DatabaseSubnetAZaParameter" {
    type = string
    description = "CIDR block of the VPC database subnet in AZ-a"
    default = "xx.xx.xx.xx/xx"
}
variable "DatabaseSubnetAZbParameter" {
    type = string
    description = "CIDR block of the VPC database subnet in AZ-b"
    default = "xx.xx.xx.xx/xx"
}
variable "DatabaseSubnetAZcParameter" {
    type = string
    description = "CIDR block of the VPC database subnet in AZ-c"
    default = "xx.xx.xx.xx/xx"
}

############## Secondary Subnet Parameter ##############
variable "SecondarySubnetAZaParameter" {
    type = string
    description = "Secondary CIDR block of the APP VPC (Not RFC1918) private subnet in AZ-a"
    default = "xx.xx.xx.xx/xx"
}
variable "SecondarySubnetAZbParameter" {
    type = string
    description = "Secondary CIDR block of the APP VPC (Not RFC1918) private subnet in AZ-b"
    default = "xx.xx.xx.xx/xx"
}
variable "SecondarySubnetAZcParameter" {
    type = string
    description = "Secondary CIDR block of the APP VPC (Not RFC1918) private subnet in AZ-c"
    default = "xx.xx.xx.xx/xx"
}

############## IGW NATGW Parameter ##############
variable "Enable_IGW_NATGW" {
  description = "If set to true, InternetGW and NATGW"
  type        = bool
  default     = false
}
############## Default Route Option ##############
variable "Default_Route_NATGW_InternetGW" {
  description = "If set to true, PublicSubnet Default Route to InternetGW and Private to NATGW else Default Route to TGW"
  type        = bool
  default     = false
}
############## Network TGW ##############
variable "TGW_Internal_ID" {
  description = "TGW Application ID (Prod:tgw-0a73023a672570807, NonProd:tgw-044cc0b97ebdc24ab)"
  type        = string
  default     = "TGW-ID"
}
variable "TGW_Inbound_ID" {
  description = "TGW Inbound ID (Prod:tgw-0cf76ed40867adbe6, NonProd:tgw-08a658ae07a7eb918)"
  type        = string
  default     = "TGW-ID"
}
variable "TGW_Rtb_Application_ID" {
  description = "TGW Rtb Application ID At ShareInfra(Prod:tgw-rtb-0996dced2915451ca, NonProd:tgw-rtb-0f04449433ba4890c)"
  type        = string
  default     = "TGW-Rtb-Application-ID"
}
variable "TGW_Rtb_Firewall_ID" {
  description = "TGW Rtb Firewall ID At ShareInfra(Prod:tgw-rtb-0095fb3586e72c733, NonProd:tgw-rtb-0f2700ae7f3d36b67)"
  type        = string
  default     = "TGW-Rtb-Firewall-ID"
}
variable "TGW_Rtb_VPNDC_ID" {
  description = "TGW Rtb VPNDC ID At ShareInfra(Prod:tgw-rtb-05d54e3bdef409825, NonProd:tgw-rtb-0cf3b47c9b41fe65b)"
  type        = string
  default     = "TGW-Rtb-VPNDC-ID"
}
variable "Att_TGW_VPNDC_to_VPC_Security" {
  description = "TGW Att VPNDC-to-VPC_Security for add route on TGW Rtb VPNDC (Prod:tgw-attach-04cf1b21f3f2794b1, NonProd:tgw-attach-01a7f9d53e6a406fc)"
  type        = string
  default     = "TGW Att VPNDC-to-VPC_Security-ID"
}
variable "TGW_Rtb_Inbound_ID" {
  description = "TGW Rtb Inbound ID At ShareInfra(Prod:tgw-rtb-0493379938b3de7f2, NonProd:tgw-rtb-0367049a1eec3679b)"
  type        = string
  default     = "TGW-Rtb-Inbound-ID"
}
variable "Att_TGW_Inbound_to_VPC_Security" {
  description = "TGW Att Att-TGW_Inbound-to-VPC_Security for add route on TGW Rtb Inbound (Prod:tgw-attach-0585f802ea287b51c, NonProd:tgw-attach-0326a6255f8f149a1)"
  type        = string
  default     = "Att-TGW_Inbound-to-VPC_Security-ID"
}
variable "NLZ_Inbound_Private_RT_ID" {
  description = "NLZ_Inbound_Private_RT_ID (Prod:rtb-0be1c67d078d06caa, NonProd:rtb-06c746ca277fc598d)"
  type        = string
  default     = "NLZ_Inbound_Private_RT_ID"
}
variable "NLZ_Inbound_Public_RT_ID" {
  description = "NLZ_Inbound_Public_RT_ID (Prod:rtb-0a1c034ce824163db, NonProd:rtb-0e5115fc3affa2b81)"
  type        = string
  default     = "NLZ_Inbound_Public_RT_ID"
}

############## VPC Peering + Add Route ##############
variable "DevOpsVPC_ID" {
  description = "DevOpsVPC_ID (Prod:vpc-0c2c230c0d43f6ccd, NonProd:vpc-0fb921aaeb734b3f7)"
  type        = string
  default     = "vpc-DevOpsVPC_ID"
}
variable "DevOps_Private_RT_ID" {
  description = "DevOps_Private_RT_ID (Prod:rtb-02941422bc0e955cf, NonProd:rtb-09dd15334b9481b40)"
  type        = string
  default     = "DevOps_Private_RT_ID"
}
variable "VAScanVPC_ID" {
  description = "VAScanVPC_ID (Prod:vpc-0bcd169a3af76d222, NonProd:vpc-088145e37fff9da48)"
  type        = string
  default     = "vpc-VAScanVPC_ID"
}
variable "VAScan_RT_ID" {
  description = "VAScan_RT_ID (Prod:rtb-0f638f6062c7ea695, NonProd:rtb-04986cc325570a618)"
  type        = string
  default     = "VAScan_RT_ID"
}

############## Key Pair Parameter ##############
variable "Enable_key_pair" {
  description = "If set to true, Create KeyPair"
  type        = bool
  default     = true
}
variable "key_name" {
    type = string
    description = "KeyPair Name"
    default = "xxxx"
}

#Jenkins
variable "Connection_Jenkins" {
    type = string
    description = "Connection Jenkins Non Prod:10.31.27.156/32 , Prod:10.31.91.89/32"
    default = "10.31.27.156/32"
}
#VA
variable "Connection_VA" {
    type = string
    description = "NonProd, Connection VAScan 10.31.26.59/32 port:All ,Prod:10.31.92.101/32"
    default = "10.31.26.59/32"
}
#ELK
variable "Connection_ELK_NonProd" {
    type = string
    description = "NonProd, Connection ELK 10.31.27.156/32 port:Request from ELK Team"
    default = "10.31.27.156/32"
}
variable "Connection_ELK_Prod" {
    type = string
    description = "Prod, Connection ELK 10.31.91.89/32 port:Request from ELK Team"
    default = "10.31.91.89/32"
}

############## EKS ##############
variable "EKS_Tag_Public_Subnet" {
    type    =   map
    description = "A list of tag for the EKS projects"
    default = {
    "kubernetes.io/cluster/ProjectX-EKS-Cluster" = "shared"
    "kubernetes.io/role/elb"               = 1
    "kubernetes.io/role/internal-elb"      = 1
    }   
}
variable "EKS_Tag_Private_Subnet" {
    type    =   map
    description = "A list of tag for the EKS projects"
    default = {
    "kubernetes.io/cluster/ProjectX-EKS-Cluster" = "shared"
    "kubernetes.io/role/internal-elb"      = 1
    }   
}
variable "EKS_Tag_Database_Subnet" {
    type    =   map
    description = "A list of tag for the EKS projects"
    default = {
    "kubernetes.io/cluster/ProjectX-EKS-Cluster" = "shared"
    }   
}