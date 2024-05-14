default_tag = {
    "environment"             =   "nonprod"
    "budget code"             =   "403812019"
    "application id"          =   "804"
    "application acronym"     =   "804_EVBikes"
    "project"                 =   "EVBikes"
    "created by"              =   "terraform"
    }

#### Application Name ####
AppName                         =   "EVBikes"
AppID                           =   "804_EVBikes"
Share_Env                       =   "devsit"
Env                             =   "dev"  #nonprod(devsit), sit , uat, nft
AccountName                     =   "kbtg-nonprod"

#### Parameter on Share-infra-nonprod account ####
#VPC Name : KBTG-Inbound
VPC_ShareInfra              =   "vpc-016e5cc43e4be8fe8" #nonprod
#Subent Name : Inbound - Public - AZ1, Inbound - Public - AZ2
Subnet_ShareInfra_AZ1       =   "subnet-0d7e222b5296acbce" #nonprod
Subnet_ShareInfra_AZ2       =   "subnet-05f2572a9800b0fe6" #nonprod

############### VPC Parameter ############### 
Enable_3_AvailabilityZone   =   false
VPCCIDRParameter            =   "10.42.97.0/24"
VPCSecondaryCIDRParameter   =   "100.97.0.0/16"

# VPC Subnet Parameter For 2 Availability Zone (Commend  3 AZ Parameter)
PublicSubnetAZaParameter     =   "10.42.97.0/27"
PublicSubnetAZbParameter     =   "10.42.97.32/27"
PrivateSubnetAZaParameter    =   "10.42.97.64/27"
PrivateSubnetAZbParameter    =   "10.42.97.96/27"
DatabaseSubnetAZaParameter   =   "10.42.97.128/27"
DatabaseSubnetAZbParameter   =   "10.42.97.160/27"
# Secondary Subnet Parameter
SecondarySubnetAZaParameter     =   "100.97.0.0/17"
SecondarySubnetAZbParameter     =   "100.97.128.0/17"

# VPC Subnet Parameter For 3 Availability Zone  (Commend  2 AZ Parameter)
# PublicSubnetAZaParameter     =   "10.42.97.0/27"
# PublicSubnetAZbParameter     =   "10.42.97.32/27"
# PublicSubnetAZcParameter     =   "10.42.97.64/27"
# PrivateSubnetAZaParameter    =   "10.42.97.96/27"
# PrivateSubnetAZbParameter    =   "10.42.97.128/27"
# PrivateSubnetAZcParameter    =   "10.42.97.160/27"
# DatabaseSubnetAZaParameter   =   "10.42.97.192/27"
# DatabaseSubnetAZbParameter   =   "10.42.97.224/28"
# DatabaseSubnetAZcParameter   =   "10.42.97.240/28"
# # Secondary Subnet Parameter
# SecondarySubnetAZaParameter     =   "100.97.0.0/18"
# SecondarySubnetAZbParameter     =   "100.97.64.0/18"
# SecondarySubnetAZcParameter     =   "100.97.128.0/18"

# IGW, NATGW
Enable_IGW_NATGW                = false

# Default Route Option
Default_Route_NATGW_InternetGW  = false

# Network TGW
## TGW Application ID (Prod:tgw-0a73023a672570807, NonProd:tgw-044cc0b97ebdc24ab)
TGW_Internal_ID             =   "tgw-044cc0b97ebdc24ab"
## TGW Inbound ID (Prod:tgw-0cf76ed40867adbe6, NonProd:tgw-08a658ae07a7eb918)
TGW_Inbound_ID              =   "tgw-08a658ae07a7eb918"
##TGW Rtb Application ID At ShareInfra(Prod:tgw-rtb-0996dced2915451ca, NonProd:tgw-rtb-0f04449433ba4890c)
TGW_Rtb_Application_ID      =   "tgw-rtb-0f04449433ba4890c"
##TGW Rtb Firewall ID At ShareInfra(Prod:tgw-rtb-0095fb3586e72c733, NonProd:tgw-rtb-0f2700ae7f3d36b67)
TGW_Rtb_Firewall_ID         =   "tgw-rtb-0f2700ae7f3d36b67"
##TGW Rtb VPNDC ID At ShareInfra(Prod:tgw-rtb-05d54e3bdef409825, NonProd:tgw-rtb-0cf3b47c9b41fe65b)
TGW_Rtb_VPNDC_ID            =   "tgw-rtb-0cf3b47c9b41fe65b"
##TGW Att VPNDC-to-VPC_Security for add route on TGW Rtb VPNDC (Prod:tgw-attach-04cf1b21f3f2794b1, NonProd:tgw-attach-01a7f9d53e6a406fc)
Att_TGW_VPNDC_to_VPC_Security   = "tgw-attach-01a7f9d53e6a406fc"
##TGW Rtb Inbound ID At ShareInfra(Prod:tgw-rtb-0493379938b3de7f2, NonProd:tgw-rtb-0367049a1eec3679b)
TGW_Rtb_Inbound_ID          =   "tgw-rtb-0367049a1eec3679b"
##TGW Att Att-TGW_Inbound-to-VPC_Security for add route on TGW Rtb Inbound (Prod:tgw-attach-0585f802ea287b51c, NonProd:tgw-attach-0326a6255f8f149a1)
Att_TGW_Inbound_to_VPC_Security   = "tgw-attach-0326a6255f8f149a1"
##NLZ_Inbound_Private_RT_ID (Prod:rtb-0be1c67d078d06caa, NonProd:rtb-06c746ca277fc598d)
NLZ_Inbound_Private_RT_ID       = "rtb-06c746ca277fc598d"
##NLZ_Inbound_Public_RT_ID (Prod:rtb-0a1c034ce824163db, NonProd:rtb-0e5115fc3affa2b81)
NLZ_Inbound_Public_RT_ID        = "rtb-0e5115fc3affa2b81"

# VPC Peering + Add Route
##DevOpsVPC_ID (Prod:vpc-0c2c230c0d43f6ccd, NonProd:vpc-0fb921aaeb734b3f7)
DevOpsVPC_ID                =   "vpc-0fb921aaeb734b3f7"
##DevOps_Private_RT_ID (Prod:rtb-02941422bc0e955cf, NonProd:rtb-09dd15334b9481b40)
DevOps_Private_RT_ID        =   "rtb-09dd15334b9481b40"
##VAScanVPC_ID (Prod:vpc-0bcd169a3af76d222, NonProd:vpc-088145e37fff9da48)
VAScanVPC_ID                =   "vpc-088145e37fff9da48"
##VAScan_RT_ID (Prod:rtb-0f638f6062c7ea695, NonProd:rtb-04986cc325570a618)
VAScan_RT_ID                =   "rtb-04986cc325570a618"

# Key Pair
Enable_key_pair             = true
key_name                    = "EVBikes-Key"     ### Edit env

#Jenkins
##  Connection Jenkins Non Prod:10.31.27.156/32 , Prod:10.31.91.89/32
Connection_Jenkins                      = "10.31.27.156/32"

#VA
##  Connection VAScan Non: Prod10.31.26.59/32 port:All , Prod:10.31.92.101/32
Connection_VA               = "10.31.26.59/32"

#ELK
Connection_ELK_NonProd      = "10.31.27.156/32"
Connection_ELK_Prod         = "10.31.91.89/32"

############## EKS ##############
EKS_Tag_Public_Subnet = {
    "kubernetes.io/cluster/EVBikes-EKS-Cluster" = "shared"
    "kubernetes.io/role/elb"               = 1
    "kubernetes.io/role/internal-elb"      = 1
    }
EKS_Tag_Private_Subnet = {
    "kubernetes.io/cluster/EVBikes-EKS-Cluster" = "shared"
    "kubernetes.io/role/internal-elb"      = 1
    }
EKS_Tag_Database_Subnet = {
    "kubernetes.io/cluster/EVBikes-EKS-Cluster" = "shared"
    }