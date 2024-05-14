####type:string,number,list(string),map(tag)

############### Provider ShareInfra #########
variable "AWS_ACCESS_KEY_ID_SHAREINFRANONPROD" {}
variable "AWS_SECRET_ACCESS_KEY_SHAREINFRANONPROD" {}
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

### IAMRole.tf
############### IAMRole Parameter ###############
variable "eksservicerole" {
    type = string
    description = "iam role for EKS service use with kms"
    default = "projectname-environment-EKS-Service-Role"
}

variable "bastionhostrole" {
    type = string
    description = "iam role of EC2 bastion host use with kms"
    default = "projectname-environment-EC2-BastionHost-Role"
}

variable "WorkerNoderole" {
    type = string
    description = "iam role name of WorkerNoderole"
    default = "projectname-environment-WorkerNodes-InstanceRole"
}

variable "WorkerNoderole_instanceprofile" {
    type = string
    description = "WorkerNoderole_instanceprofile name of WorkerNoderole"
    default = "projectname-environment-WorkerNodes-InstanceProfile"
}

############### Policy Name Parameter ###############
variable "applicationpolicyname" {
    type = string
    description = "name of application Policy"
    default = "projectname-environment-App-Policy"
}
variable "s3managedpolicyname" {
    type = string
    description = "name of S3 Managed Policy"
    default = "projectname-environment-S3-Policy"
}
variable "kmsmanagedpolicyname" {
    type = string
    description = "name of KMS S3 Managed Policy"
    default = "projectname-environment-KMS-Policy"
}
variable "bastionhostpolicyname" {
    type = string
    description = "name of Bastionhost Managed Policy"
    default = "projectname-environment-S3-Managed-Policy"
}

############### S3 ###############
variable "bucketS3" {
    type = string
    description = "name of S3 for application bucket"
    default = "appid-projectname-environment-bucket"
}

variable "bucketJenkins" {
    type = string
    description = "name of S3 for jenkins bucket"
    default = "appid-projectname-environment-jenkins-bucket"
}

