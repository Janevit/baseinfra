resource "time_sleep" "wait_allsubnet_create" {
  create_duration = "20s"
  depends_on = [aws_vpc.vpc_main,aws_vpc_ipv4_cidr_block_association.secondary_cidr]
}

#########################
########## VPC ##########
#########################
resource "aws_vpc" "vpc_main" {
    cidr_block       = var.VPCCIDRParameter
    enable_dns_support = true
    enable_dns_hostnames = true
    instance_tenancy = "default"

    tags = merge(
        var.default_tag,
        {
        Name = "${var.AppName}-VPC"
        }
    )    
}

resource "aws_vpc_ipv4_cidr_block_association" "secondary_cidr" {
  vpc_id     = aws_vpc.vpc_main.id
  cidr_block = var.VPCSecondaryCIDRParameter
  depends_on = [aws_vpc.vpc_main]
}

#Output VPC
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.vpc_main.id
}
#####################################
########## Subnet VPC Main ##########
#####################################
# Public subnets Availabilityzone A
resource "aws_subnet" "PublicSubnetAZa" {
    vpc_id     = aws_vpc.vpc_main.id
    cidr_block = var.PublicSubnetAZaParameter
    availability_zone = "ap-southeast-1a"
    map_public_ip_on_launch = false
    depends_on = [aws_vpc.vpc_main,aws_vpc_ipv4_cidr_block_association.secondary_cidr]

    tags = merge(
        var.default_tag,
        var.EKS_Tag_Public_Subnet,
        {
        Name = "${var.AppName}-PublicSubnet-AZa"
        # "kubernetes.io/cluster/${var.AppName}-EKS-Cluster" = "shared"
        # "kubernetes.io/role/elb"               = 1
        # "kubernetes.io/role/internal-elb"      = 1      
        }
    )  
}
output "PublicSubnetAZa_id" {
  description = "ID of the PublicSubnetAZa"
  value       = try(aws_subnet.PublicSubnetAZa.id,"")
}
# Public subnets Availabilityzone B
resource "aws_subnet" "PublicSubnetAZb" {
    vpc_id     = aws_vpc.vpc_main.id
    cidr_block = var.PublicSubnetAZbParameter
    availability_zone = "ap-southeast-1b"
    map_public_ip_on_launch = false
    depends_on = [aws_vpc.vpc_main,aws_vpc_ipv4_cidr_block_association.secondary_cidr]

    tags = merge(
        var.default_tag,
        var.EKS_Tag_Public_Subnet,
        {
        Name = "${var.AppName}-PublicSubnet-AZb"
        # "kubernetes.io/cluster/${var.AppName}-EKS-Cluster" = "shared"
        # "kubernetes.io/role/elb"               = 1
        # "kubernetes.io/role/internal-elb"      = 1
        }
    )
}
output "PublicSubnetAZb_id" {
  description = "ID of the PublicSubnetAZb"
  value       = try(aws_subnet.PublicSubnetAZb.id,"")
}
# Private subnets Availabilityzone A
resource "aws_subnet" "PrivateSubnetAZa" {
    vpc_id     = aws_vpc.vpc_main.id
    cidr_block = var.PrivateSubnetAZaParameter
    availability_zone = "ap-southeast-1a"
    map_public_ip_on_launch = false
    depends_on = [aws_vpc.vpc_main,aws_vpc_ipv4_cidr_block_association.secondary_cidr]
    
    tags = merge(
        var.default_tag,
        var.EKS_Tag_Private_Subnet,
        {
        Name = "${var.AppName}-PrivateSubnet-AZa"
        # "kubernetes.io/cluster/${var.AppName}-EKS-Cluster" = "shared"
        # "kubernetes.io/role/internal-elb"      = 1
        }
    )
}
output "PrivateSubnetAZa_id" {
  description = "ID of the PrivateSubnetAZa"
  value       = try(aws_subnet.PrivateSubnetAZa.id,"")
}
# Private subnets Availabilityzone B
resource "aws_subnet" "PrivateSubnetAZb" {
    vpc_id     = aws_vpc.vpc_main.id
    cidr_block = var.PrivateSubnetAZbParameter
    availability_zone = "ap-southeast-1b"
    map_public_ip_on_launch = false
    depends_on = [aws_vpc.vpc_main,aws_vpc_ipv4_cidr_block_association.secondary_cidr]
    
    tags = merge(
        var.default_tag,
        var.EKS_Tag_Private_Subnet,
        {
        Name = "${var.AppName}-PrivateSubnet-AZb"
        # "kubernetes.io/cluster/${var.AppName}-EKS-Cluster" = "shared"
        # "kubernetes.io/role/internal-elb"      = 1
        }
    )
}
output "PrivateSubnetAZb_id" {
  description = "ID of the PrivateSubnetAZb"
  value       = try(aws_subnet.PrivateSubnetAZb.id,"")
}
# Database subnets Availabilityzone A
resource "aws_subnet" "DatabaseSubnetAZa" {
    vpc_id     = aws_vpc.vpc_main.id
    cidr_block = var.DatabaseSubnetAZaParameter
    availability_zone = "ap-southeast-1a"
    map_public_ip_on_launch = false
    depends_on = [aws_vpc.vpc_main,aws_vpc_ipv4_cidr_block_association.secondary_cidr]
    
    tags = merge(
        var.default_tag,
        var.EKS_Tag_Database_Subnet,
        {
        Name = "${var.AppName}-DatabaseSubnet-AZa"
        # "kubernetes.io/cluster/${var.AppName}-EKS-Cluster" = "shared"
        }
    )
}
output "DatabaseSubnetAZa_id" {
  description = "ID of the DatabaseSubnetAZa"
  value       = try(aws_subnet.DatabaseSubnetAZa.id,"")
}
# Database subnets Availabilityzone B
resource "aws_subnet" "DatabaseSubnetAZb" {
    vpc_id     = aws_vpc.vpc_main.id
    cidr_block = var.DatabaseSubnetAZbParameter
    availability_zone = "ap-southeast-1b"
    map_public_ip_on_launch = false
    depends_on = [aws_vpc.vpc_main,aws_vpc_ipv4_cidr_block_association.secondary_cidr]

    tags = merge(
        var.default_tag,
        var.EKS_Tag_Database_Subnet,
        {
        Name = "${var.AppName}-DatabaseSubnet-AZb"
        # "kubernetes.io/cluster/${var.AppName}-EKS-Cluster" = "shared"
        }
    )
}
output "DatabaseSubnetAZb_id" {
    description = "ID of the DatabaseSubnetAZb"
    value       = try(aws_subnet.DatabaseSubnetAZb.id,"")
}
# Public subnets Availabilityzone C
resource "aws_subnet" "PublicSubnetAZc" {
    count = var.Enable_3_AvailabilityZone ? 1 : 0
    vpc_id     = aws_vpc.vpc_main.id
    cidr_block = var.PublicSubnetAZcParameter
    availability_zone = "ap-southeast-1c"
    map_public_ip_on_launch = false
    depends_on = [aws_vpc.vpc_main,aws_vpc_ipv4_cidr_block_association.secondary_cidr]

    tags = merge(
        var.default_tag,
        var.EKS_Tag_Public_Subnet,
        {
        Name = "${var.AppName}-PublicSubnet-AZc"
        # "kubernetes.io/cluster/${var.AppName}-EKS-Cluster" = "shared"
        # "kubernetes.io/role/elb"               = 1
        # "kubernetes.io/role/internal-elb"      = 1
        }
    )
}
output "PublicSubnetAZc_id" {
  description = "ID of the PublicSubnetAZc"
  value       = try(aws_subnet.PublicSubnetAZc[0].id, "")
}
# Private subnets Availabilityzone C
resource "aws_subnet" "PrivateSubnetAZc" {
    count = var.Enable_3_AvailabilityZone ? 1 : 0
    vpc_id     = aws_vpc.vpc_main.id
    cidr_block = var.PrivateSubnetAZcParameter
    availability_zone = "ap-southeast-1c"
    map_public_ip_on_launch = false
    depends_on = [aws_vpc.vpc_main,aws_vpc_ipv4_cidr_block_association.secondary_cidr]
    
    tags = merge(
        var.default_tag,
        var.EKS_Tag_Private_Subnet,
        {
        Name = "${var.AppName}-PrivateSubnet-AZc"
        # "kubernetes.io/cluster/${var.AppName}-EKS-Cluster" = "shared"
        # "kubernetes.io/role/internal-elb"      = 1
        }
    )
}
output "PrivateSubnetAZc_id" {
  description = "ID of the PrivateSubnetAZc"
  value       = try(aws_subnet.PrivateSubnetAZc[0].id, "")
}
# Database subnets Availabilityzone C
resource "aws_subnet" "DatabaseSubnetAZc" {
    count = var.Enable_3_AvailabilityZone ? 1 : 0
    vpc_id     = aws_vpc.vpc_main.id
    cidr_block = var.DatabaseSubnetAZcParameter
    availability_zone = "ap-southeast-1c"
    map_public_ip_on_launch = false
    depends_on = [aws_vpc.vpc_main,aws_vpc_ipv4_cidr_block_association.secondary_cidr]

    tags = merge(
        var.default_tag,
        var.EKS_Tag_Database_Subnet,
        {
        Name = "${var.AppName}-DatabaseSubnet-AZc"
        # "kubernetes.io/cluster/${var.AppName}-EKS-Cluster" = "shared"
        }
    )
}
output "DatabaseSubnetAZc_id" {
    description = "ID of the DatabaseSubnetAZc"
    value       = try(aws_subnet.DatabaseSubnetAZc[0].id, "")
}
##########################################
########## Subnet VPC Secondary ##########
##########################################
# Secondary subnets Availabilityzone A
resource "aws_subnet" "SecondarySubnetAZa" {
    vpc_id     = aws_vpc.vpc_main.id
    cidr_block = var.SecondarySubnetAZaParameter
    availability_zone = "ap-southeast-1a"
    map_public_ip_on_launch = false
    depends_on = [aws_vpc.vpc_main,aws_vpc_ipv4_cidr_block_association.secondary_cidr]

    tags = merge(
        var.default_tag,
        var.EKS_Tag_Database_Subnet,
        {
        Name = "${var.AppName}-SecondarySubnet-AZa"
        # "kubernetes.io/cluster/${var.AppName}-EKS-Cluster" = "shared"
        }
    )
}
output "SecondarySubnetAZa_id" {
    description = "ID of the SecondarySubnetAZa"
    value       = try(aws_subnet.SecondarySubnetAZa.id,"")
}
# Secondary subnets Availabilityzone B
resource "aws_subnet" "SecondarySubnetAZb" {
    vpc_id     = aws_vpc.vpc_main.id
    cidr_block = var.SecondarySubnetAZbParameter
    availability_zone = "ap-southeast-1b"
    map_public_ip_on_launch = false
    depends_on = [aws_vpc.vpc_main,aws_vpc_ipv4_cidr_block_association.secondary_cidr]

    tags = merge(
        var.default_tag,
        var.EKS_Tag_Database_Subnet,
        {
        Name = "${var.AppName}-SecondarySubnet-AZb"
        # "kubernetes.io/cluster/${var.AppName}-EKS-Cluster" = "shared"
        }
    )
}
output "SecondarySubnetAZb_id" {
    description = "ID of the SecondarySubnetAZb"
    value       = try(aws_subnet.SecondarySubnetAZb.id,"")
}
# Secondary subnets Availabilityzone C
resource "aws_subnet" "SecondarySubnetAZc" {
    count = var.Enable_3_AvailabilityZone ? 1 : 0
    vpc_id     = aws_vpc.vpc_main.id
    cidr_block = var.SecondarySubnetAZcParameter
    availability_zone = "ap-southeast-1c"
    map_public_ip_on_launch = false
    depends_on = [aws_vpc.vpc_main,aws_vpc_ipv4_cidr_block_association.secondary_cidr]

    tags = merge(
        var.default_tag,
        var.EKS_Tag_Database_Subnet,
        {
        Name = "${var.AppName}-SecondarySubnet-AZc"
        }
    )
}
output "SecondarySubnetAZc_id" {
    description = "ID of the SecondarySubnetAZc"
    value       = try(aws_subnet.SecondarySubnetAZc[0].id, "")
}
######################################
########## Internet Gateyay ##########
######################################
resource "aws_internet_gateway" "VPCIGW" {
    count = var.Enable_IGW_NATGW ? 1 : 0
    
    vpc_id = aws_vpc.vpc_main.id
    depends_on = [aws_vpc.vpc_main,aws_vpc_ipv4_cidr_block_association.secondary_cidr]

    tags = merge(
        var.default_tag,
        {
        Name = "${var.AppName}-VPC-IGW"
        }
    )
}
output "VPCIGW_id" {
    description = "ID of the VPCIGW"
    # value       = aws_internet_gateway.VPCIGW[count.index].id
    value       = try(aws_internet_gateway.VPCIGW[0].id, "")
}

#########################################
########## NAT Gateways (NGWs) ##########
#########################################
resource "aws_eip" "VPCAZaEIP" {
    count = var.Enable_IGW_NATGW ? 1 : 0    
    tags = merge(
        var.default_tag,
        {
        Name = "${var.AppName}-EIP-NGW-AZa"
        }
    )
}
output "VPCAZaEIP_id" {
    description = "ID of the VPCAZaEIP"
    # value       = aws_internet_gateway.VPCIGW[count.index].id
    value       = try(aws_eip.VPCAZaEIP[0].id, "")
}
output "VPCAZaEIP-IP" {
    description = "Public_ip of the VPCAZaEIP"
    # value       = aws_internet_gateway.VPCIGW[count.index].id
    value       = try(aws_eip.VPCAZaEIP[0].public_ip, "")
}   

resource "aws_nat_gateway" "VPCAZaNGW" {
    count = var.Enable_IGW_NATGW ? 1 : 0    
    connectivity_type = "public"
    allocation_id = aws_eip.VPCAZaEIP[0].id
    subnet_id     = aws_subnet.PublicSubnetAZa.id
    depends_on = [aws_subnet.PublicSubnetAZa,aws_eip.VPCAZaEIP] 

    tags = merge(
        var.default_tag,
        {
        Name = "${var.AppName}-NGW-AZa"
        }
    ) 
}
output "VPCAZaNGW_id" {
    description = "ID of the VPCAZaNGW"
    # value       = aws_internet_gateway.VPCIGW[count.index].id
    value       = try(aws_nat_gateway.VPCAZaNGW[0].id, "")
}

#########################################
########## Route Tables (RTs) ###########
#########################################
resource "aws_route_table" "PublicRT" {
    vpc_id = aws_vpc.vpc_main.id
    depends_on = [aws_vpc.vpc_main,aws_vpc_ipv4_cidr_block_association.secondary_cidr]
    # route {
    #     cidr_block = "10.0.1.0/24"
    #     gateway_id = aws_internet_gateway.example.id
    # }

        tags = merge(
            var.default_tag,
            {
            Name = "${var.AppName}-PublicRT"
            }
        ) 
}
output "PublicRT_id" {
    description = "ID of the PublicRT"
    value       = try(aws_route_table.PublicRT.id,"")
}
resource "aws_route_table" "PrivateRT" {
    vpc_id = aws_vpc.vpc_main.id
    depends_on = [aws_vpc.vpc_main,aws_vpc_ipv4_cidr_block_association.secondary_cidr]
    # route {
    #     cidr_block = "10.0.1.0/24"
    #     gateway_id = aws_internet_gateway.example.id
    # }

        tags = merge(
            var.default_tag,
            {
            Name = "${var.AppName}-PrivateRT"
            }
        ) 
}
output "PrivateRT_id" {
    description = "ID of the PrivateRT"
    value       = try(aws_route_table.PrivateRT.id,"")
}
############################################
########## Attach Subnets to RTs ###########
############################################
#Attach Public Subnets to RTs
resource "aws_route_table_association" "PublicSubnetAZaRouteTableAssociation" {
    subnet_id      = aws_subnet.PublicSubnetAZa.id
    route_table_id = aws_route_table.PublicRT.id
    depends_on = [aws_subnet.PublicSubnetAZa,aws_route_table.PublicRT]
}
resource "aws_route_table_association" "PublicSubnetAZbRouteTableAssociation" {
    subnet_id      = aws_subnet.PublicSubnetAZb.id
    route_table_id = aws_route_table.PublicRT.id
    depends_on = [aws_subnet.PublicSubnetAZb,aws_route_table.PublicRT]
}
resource "aws_route_table_association" "PublicSubnetAZcRouteTableAssociation" {
    count = var.Enable_3_AvailabilityZone ? 1 : 0
    subnet_id      = aws_subnet.PublicSubnetAZc[0].id
    route_table_id = aws_route_table.PublicRT.id
    depends_on = [aws_subnet.PublicSubnetAZc[0],aws_route_table.PublicRT]
}
#Attach Private Subnets to RTs
resource "aws_route_table_association" "PrivateSubnetAZaRouteTableAssociation" {
    subnet_id      = aws_subnet.PrivateSubnetAZa.id
    route_table_id = aws_route_table.PrivateRT.id
    depends_on = [aws_subnet.PrivateSubnetAZa,aws_route_table.PrivateRT]
}
resource "aws_route_table_association" "PrivateSubnetAZbRouteTableAssociation" {
    subnet_id      = aws_subnet.PrivateSubnetAZb.id
    route_table_id = aws_route_table.PrivateRT.id
    depends_on = [aws_subnet.PrivateSubnetAZb,aws_route_table.PrivateRT]
}
resource "aws_route_table_association" "PrivateSubnetAZcRouteTableAssociation" {
    count = var.Enable_3_AvailabilityZone ? 1 : 0
    subnet_id      = aws_subnet.PrivateSubnetAZc[0].id
    route_table_id = aws_route_table.PrivateRT.id
    depends_on = [aws_subnet.PrivateSubnetAZc[0],aws_route_table.PrivateRT]
}
################################################
################ Network TGW ###################
################################################
resource "aws_ec2_transit_gateway_vpc_attachment" "TGW_Internal_App_Att" {
    # subnet_ids         = [aws_subnet.PrivateSubnetAZa.id,aws_subnet.PrivateSubnetAZb.id]
    subnet_ids         = var.Enable_3_AvailabilityZone ? [aws_subnet.PrivateSubnetAZa.id,aws_subnet.PrivateSubnetAZb.id,aws_subnet.PrivateSubnetAZc[0].id] : [aws_subnet.PrivateSubnetAZa.id,aws_subnet.PrivateSubnetAZb.id]
    transit_gateway_id = var.TGW_Internal_ID
    vpc_id             = aws_vpc.vpc_main.id
    depends_on         = [aws_vpc.vpc_main,aws_subnet.PrivateSubnetAZa,aws_subnet.PrivateSubnetAZb,time_sleep.wait_allsubnet_create]

    tags = merge(
        var.default_tag,
        {
        Name = "Share-Internal-${var.AppName}-Att"
        Side = "Requester"
        }
    ) 
}
output "TGW_Internal_App_Att" {
    description = "ID of TGW_Internal_App_Att"
    value       = try(aws_ec2_transit_gateway_vpc_attachment.TGW_Internal_App_Att.id,"")
}

# # Sleep for wait aws_ec2_transit_gateway_vpc_attachment and aws_ec2_transit_gateway_vpc_attachment_accepter finish
resource "time_sleep" "wait_tgwatt_tgwattaccepter_create" {
  create_duration = "240s"
  depends_on = [aws_ec2_transit_gateway_vpc_attachment.TGW_Internal_App_Att]
}


# # Accept it in the ShareInfra account.  
# # For NonProd: Not Need this Block because TGW at ShareInfra NonPord set auto Accept at TGW
# # For Prod: Need this Block because TGW at ShareInfra Pord  do not set auto Accept at TGW
resource "aws_ec2_transit_gateway_vpc_attachment_accepter" "TGW_ShareInfra_Internal_Accept" {
    provider = aws.ShareInfra
    count = var.Env == "prod" ? 1 : 0

    transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.TGW_Internal_App_Att.id
    depends_on = [aws_ec2_transit_gateway_vpc_attachment.TGW_Internal_App_Att]

       tags = merge(
         var.default_tag,
         {
         Name = "Share-Internal-${var.AppName}-Att"
         Side = "Accepter"
         }
     )

    lifecycle {
          #Ignore changes RDS Role Policy Attachment (UAT need to Attach) 
        ignore_changes = [transit_gateway_default_route_table_association,
            transit_gateway_default_route_table_propagation  
        ]
    }  
}
resource "aws_ec2_transit_gateway_route_table_association" "TGW_Rtb_Application_Association" {
    provider = aws.ShareInfra
    transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.TGW_Internal_App_Att.id
    transit_gateway_route_table_id = var.TGW_Rtb_Application_ID
    depends_on = [aws_ec2_transit_gateway_vpc_attachment.TGW_Internal_App_Att,time_sleep.wait_tgwatt_tgwattaccepter_create]
    # For Prod 
    #depends_on  = [aws_ec2_transit_gateway_vpc_attachment.TGW_Internal_App_Att,aws_ec2_transit_gateway_vpc_attachment_accepter.TGW_ShareInfra_Internal_Accept]
}
resource "aws_ec2_transit_gateway_route_table_propagation" "TGW_Rtb_Firewall_Propagation" {
    provider = aws.ShareInfra    
    transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.TGW_Internal_App_Att.id
    transit_gateway_route_table_id = var.TGW_Rtb_Firewall_ID
    depends_on = [aws_ec2_transit_gateway_vpc_attachment.TGW_Internal_App_Att,time_sleep.wait_tgwatt_tgwattaccepter_create]
    # For Prod 
    #depends_on  = [aws_ec2_transit_gateway_vpc_attachment.TGW_Internal_App_Att,aws_ec2_transit_gateway_vpc_attachment_accepter.TGW_ShareInfra_Internal_Accept]  
}
resource "aws_ec2_transit_gateway_route" "TGW_Rtb_VPNDC_Route" {
    provider = aws.ShareInfra
    destination_cidr_block         = var.VPCCIDRParameter
    transit_gateway_attachment_id  = var.Att_TGW_VPNDC_to_VPC_Security
    transit_gateway_route_table_id = var.TGW_Rtb_VPNDC_ID
    depends_on = [aws_ec2_transit_gateway_vpc_attachment.TGW_Internal_App_Att,time_sleep.wait_tgwatt_tgwattaccepter_create]
    # For Prod 
    #depends_on  = [aws_ec2_transit_gateway_vpc_attachment.TGW_Internal_App_Att,aws_ec2_transit_gateway_vpc_attachment_accepter.TGW_ShareInfra_Internal_Accept]
}
resource "aws_ec2_transit_gateway_route" "TGW_Rtb_Inbound_Route" {
    provider = aws.ShareInfra
    destination_cidr_block         = var.VPCCIDRParameter
    transit_gateway_attachment_id  = var.Att_TGW_Inbound_to_VPC_Security
    transit_gateway_route_table_id = var.TGW_Rtb_Inbound_ID 
    depends_on = [aws_ec2_transit_gateway_vpc_attachment.TGW_Internal_App_Att,time_sleep.wait_tgwatt_tgwattaccepter_create]
    # For Prod 
    #depends_on  = [aws_ec2_transit_gateway_vpc_attachment.TGW_Internal_App_Att,aws_ec2_transit_gateway_vpc_attachment_accepter.TGW_ShareInfra_Internal_Accept]
}
# Add Route on NLZ_Inbound-Private RT at VPC Inbound [Shainfra VPC Inbound->Firewall->App]
resource "aws_route" "Rule_Inbound_Private_Subnet_to_TGW_Inbound" {
    provider = aws.ShareInfra
    route_table_id            = var.NLZ_Inbound_Private_RT_ID
    destination_cidr_block    = var.VPCCIDRParameter
    transit_gateway_id        = var.TGW_Inbound_ID
    depends_on                = [aws_ec2_transit_gateway_vpc_attachment.TGW_Internal_App_Att,aws_ec2_transit_gateway_route.TGW_Rtb_Inbound_Route]
    # For Prod 
    #depends_on                = [aws_ec2_transit_gateway_vpc_attachment.TGW_Internal_App_Att,aws_ec2_transit_gateway_route.TGW_Rtb_Inbound_Route,aws_ec2_transit_gateway_vpc_attachment_accepter.TGW_ShareInfra_Internal_Accept]
}
# Add Route on NLZ_Inbound-Public RT at VPC Inbound [Shainfra VPC Inbound->Firewall->App]
resource "aws_route" "Rule_Inbound_Public_Subnet_to_TGW_Inbound" {
    provider = aws.ShareInfra
    route_table_id            = var.NLZ_Inbound_Public_RT_ID
    destination_cidr_block    = var.VPCCIDRParameter
    transit_gateway_id        = var.TGW_Inbound_ID
    depends_on                = [aws_ec2_transit_gateway_vpc_attachment.TGW_Internal_App_Att,aws_ec2_transit_gateway_route.TGW_Rtb_Inbound_Route]
    # For Prod 
    #depends_on                = [aws_ec2_transit_gateway_vpc_attachment.TGW_Internal_App_Att,aws_ec2_transit_gateway_route.TGW_Rtb_Inbound_Route,aws_ec2_transit_gateway_vpc_attachment_accepter.TGW_ShareInfra_Internal_Accept]
}
############################################
######### VPC Peering + Add Route ##########
############################################

####### Peering Application To DevOps (Same AWS Account, Same Region)
resource "aws_vpc_peering_connection" "Peering_App_to_DevOps" {
    peer_vpc_id   = var.DevOpsVPC_ID 
    vpc_id        = aws_vpc.vpc_main.id
    auto_accept   = true
    depends_on = [aws_vpc.vpc_main,aws_vpc_ipv4_cidr_block_association.secondary_cidr]
 
    tags = merge(
        var.default_tag,
        {
        Name = "${var.AppName}-DevOps"
        }
    )  
}
output "Peering_App_to_DevOps" {
    description = "ID of Peering_App_to_DevOps"
    value       = try(aws_vpc_peering_connection.Peering_App_to_DevOps.id,"")
}
output "Peering_App_to_DevOps_Status" {
    description = "Status of Peering_App_to_DevOps"
    value       = try(aws_vpc_peering_connection.Peering_App_to_DevOps.accept_status,"")
}
# Add Route on DevOps-Private-RT at VPC DevOpsTestVPC [DevOps->App]
resource "aws_route" "Rule_DevOps_Private_RT_to_App" {
    route_table_id            = var.DevOps_Private_RT_ID
    destination_cidr_block    = var.VPCCIDRParameter
    vpc_peering_connection_id = aws_vpc_peering_connection.Peering_App_to_DevOps.id
    depends_on                = [aws_vpc_peering_connection.Peering_App_to_DevOps]
}
# Add Route on PrivateRT at VPC ApplicationVPC [App->DevOps]
data "aws_vpc" "DevOpsVPC" {
    id = var.DevOpsVPC_ID 
}
resource "aws_route" "Rule_Private_RT_to_DevOps" {
    route_table_id            = aws_route_table.PrivateRT.id
    destination_cidr_block    = data.aws_vpc.DevOpsVPC.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.Peering_App_to_DevOps.id
    depends_on                = [aws_vpc_peering_connection.Peering_App_to_DevOps,aws_route_table.PrivateRT]
}

#######################################################################################
####### Peering Application To VAScan(Account:kbtg-security) (between AWS Account, Same Region)

# Requester's side of the connection.
resource "aws_vpc_peering_connection" "Peering_App_to_VAScan" {
    vpc_id        = aws_vpc.vpc_main.id
    peer_vpc_id   = var.VAScanVPC_ID    
    peer_owner_id = data.aws_caller_identity.caller_identity_security.account_id
    peer_region   = "ap-southeast-1"
    auto_accept   = false
    depends_on = [aws_vpc.vpc_main,aws_vpc_ipv4_cidr_block_association.secondary_cidr]

    tags = merge(
        var.default_tag,
        {
        Name = "${var.AppName}-VAScan"
        Side = "Requester"
        }
    )  
}
# Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "Peering_App_to_VAScan" {
    provider                  = aws.Security
    vpc_peering_connection_id = aws_vpc_peering_connection.Peering_App_to_VAScan.id
    auto_accept               = true
    depends_on = [aws_vpc_peering_connection.Peering_App_to_VAScan]
    tags = merge(
        var.default_tag,
        {
        Name = "${var.AppName}-VAScan"
        Side = "Accepter"
        }
    )  
}
output "Peering_App_to_VAScan" {
    description = "ID of Peering_App_to_VAScan"
    value       = try(aws_vpc_peering_connection_accepter.Peering_App_to_VAScan.id,"")
}
output "Peering_App_to_VAScan_Status" {
    description = "Status of Peering_App_to_VAScan"
    value       = try(aws_vpc_peering_connection_accepter.Peering_App_to_VAScan.accept_status,"")
}
# Add Route on VAScan-Private-RT at VPC VAScanTestVPC [VAScan->App]
resource "aws_route" "Rule_VAScan_RT_to_App" {
    provider = aws.Security    
    route_table_id            = var.VAScan_RT_ID
    destination_cidr_block    = var.VPCCIDRParameter
    vpc_peering_connection_id = aws_vpc_peering_connection_accepter.Peering_App_to_VAScan.id
    depends_on                = [aws_vpc_peering_connection_accepter.Peering_App_to_VAScan]
}
# Add Route on PrivateRT at VPC ApplicationVPC [App->VAScan]
data "aws_vpc" "VAScanVPC" {
    provider = aws.Security
    id = var.VAScanVPC_ID 
}
resource "aws_route" "Rule_Private_RT_to_VAScan" {
    route_table_id            = aws_route_table.PrivateRT.id
    destination_cidr_block    = data.aws_vpc.VAScanVPC.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.Peering_App_to_VAScan.id
    depends_on                = [aws_vpc_peering_connection.Peering_App_to_VAScan,aws_route_table.PrivateRT]
}

############################################
########## Default Route Option ############
############################################
resource "aws_route" "Rule_DefaultRoute_Public_RT_to_IGW" {
    count                     = var.Default_Route_NATGW_InternetGW && var.Enable_IGW_NATGW ? 1 : 0
    route_table_id            = aws_route_table.PublicRT.id
    destination_cidr_block    = "0.0.0.0/0"
    gateway_id                = aws_internet_gateway.VPCIGW[0].id
    depends_on                = [aws_internet_gateway.VPCIGW[0],aws_route_table.PublicRT]
}
resource "aws_route" "Rule_DefaultRoute_Private_RT_to_NATGW" {
    count                     = var.Default_Route_NATGW_InternetGW && var.Enable_IGW_NATGW ? 1 : 0
    route_table_id            = aws_route_table.PrivateRT.id
    destination_cidr_block    = "0.0.0.0/0"
    nat_gateway_id            = aws_nat_gateway.VPCAZaNGW[0].id
    depends_on                = [aws_nat_gateway.VPCAZaNGW[0],aws_route_table.PrivateRT]
}
resource "aws_route" "Rule_DefaultRoute_Public_RT_to_TGW" {
    count                     = var.Default_Route_NATGW_InternetGW ? 0 : 1
    route_table_id            = aws_route_table.PublicRT.id
    destination_cidr_block    = "0.0.0.0/0"
    transit_gateway_id        = var.TGW_Internal_ID
    depends_on                = [aws_ec2_transit_gateway_vpc_attachment.TGW_Internal_App_Att,aws_route_table.PublicRT]
}
resource "aws_route" "Rule_DefaultRoute_Private_RT_to_TGW" {
    count                     = var.Default_Route_NATGW_InternetGW ? 0 : 1
    route_table_id            = aws_route_table.PrivateRT.id
    destination_cidr_block    = "0.0.0.0/0"
    transit_gateway_id        = var.TGW_Internal_ID
    depends_on                = [aws_ec2_transit_gateway_vpc_attachment.TGW_Internal_App_Att,aws_route_table.PrivateRT]
}

############################################
###### key_pair For Bastion and EC2 ########
############################################
resource "tls_private_key" "tls_key_pair" {
    count = var.Enable_key_pair ? 1 : 0
    algorithm = "RSA"
    rsa_bits  = 4096
}
output "tls_key_pair" {
    description = "Private Key of Keypair"
    sensitive = true
    # value       = aws_internet_gateway.VPCIGW[count.index].id
    value       = try(tls_private_key.tls_key_pair[0].private_key_pem, "")
}
resource "aws_key_pair" "key_pair" {
    count = var.Enable_key_pair ? 1 : 0
    key_name   = var.key_name
    public_key = tls_private_key.tls_key_pair[0].public_key_openssh
}
output "key_pair" {
    description = "key_pair"
    # value       = aws_internet_gateway.VPCIGW[count.index].id
    value       = try(aws_key_pair.key_pair[0].key_name, "")
}
# # VPC Endpoint
# resource "aws_vpc_endpoint" "s3" {
#   provider   = aws.src
#   vpc_id     = aws_vpc.vpc.id
#   service_name = "com.amazonaws.ap-southeast-1.s3"
#   vpc_endpoint_type = "Gateway"
# }


# resource "aws_vpc_endpoint" "athena" {
#   provider   = aws.src
#   vpc_id     = aws_vpc.vpc.id
#   service_name      = "com.amazonaws.ap-southeast-1.athena"
#   vpc_endpoint_type = "Interface"

#   security_group_ids = [
#     aws_security_group.vpce_sg.id,
#   ]

#   private_dns_enabled = true
# }

# resource "aws_vpc_endpoint" "sagemaker_runtime" {
#   provider   = aws.src
#   vpc_id     = aws_vpc.vpc.id
#   service_name      = "com.amazonaws.ap-southeast-1.sagemaker.runtime"
#   vpc_endpoint_type = "Interface"

#   security_group_ids = [
#     aws_security_group.vpce_sg.id,
#   ]

#   private_dns_enabled = true
# }

# resource "aws_vpc_endpoint" "codeartifact_api" {
#   provider   = aws.src
#   vpc_id     = aws_vpc.vpc.id
#   service_name      = "com.amazonaws.ap-southeast-1.codeartifact.api"
#   vpc_endpoint_type = "Interface"

#   security_group_ids = [
#     aws_security_group.vpce_sg.id,
#   ]

#   private_dns_enabled = true
# }

# resource "aws_vpc_endpoint" "ec2" {
#   provider   = aws.src
#   vpc_id     = aws_vpc.vpc.id
#   service_name      = "com.amazonaws.ap-southeast-1.ec2"
#   vpc_endpoint_type = "Interface"

#   security_group_ids = [
#     aws_security_group.vpce_sg.id,
#   ]

#   private_dns_enabled = true
# }

# resource "aws_vpc_endpoint" "codeartifact_repositories" {
#   provider   = aws.src
#   vpc_id     = aws_vpc.vpc.id
#   service_name      = "com.amazonaws.ap-southeast-1.codeartifact.repositories"
#   vpc_endpoint_type = "Interface"

#   security_group_ids = [
#     aws_security_group.vpce_sg.id,
#   ]

#   private_dns_enabled = true
# }

# resource "aws_vpc_endpoint" "sagemaker_api" {
#   provider   = aws.src
#   vpc_id            = aws_vpc.vpc.id
#   service_name      = "com.amazonaws.ap-southeast-1.sagemaker.api"
#   vpc_endpoint_type = "Interface"

#   security_group_ids = [
#     aws_security_group.vpce_sg.id,
#   ]

#   private_dns_enabled = true
# }