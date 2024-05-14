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

### ACM-External.tf
############### ACM Parameter ############### 
variable "ACM_private_key" {
    type = string
    description = "path of private key file for certificate manager"
    default = "xxx.key"
}

variable "ACM_cert_body" {
    type = string
    description = "path of body file for certificate manager"
    default = "xxx.crt"
}

variable "ACM_cert_chain" {
    type = string
    description = "path of chain file for certificate manager"
    default = "xxx-chain.crt"
}