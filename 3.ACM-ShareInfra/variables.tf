####type:string,number,list(string),map(tag)
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

variable "AppID" {
    type = string
    description = "Application ID"
    default = "xxx.xx"
}

variable "AccountName" {
    type = string
    description = "AccountName"
    default = "xxx.xx"
}

### ACM.tf
############### ACM Parameter ############### 
variable "Amazon_issued_certificate_1" {
    type = string
    description = "Application Domain"
    default = "xxx.com"
}