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

#### IAM Role Parameter ####
eksservicerole                  =   "EVBikes-devsit-EKS-Service-Role"
bastionhostrole                 =   "EVBikes-devsit-EC2-BastionHost-Role"
WorkerNoderole                  =   "EVBikes-dev-WorkerNodes-InstanceRole"
WorkerNoderole_instanceprofile  =   "EVBikes-dev-WorkerNodes-InstanceProfile"

#### Policy ####
applicationpolicyname       =   "EVBikes-dev-App-Policy"
s3managedpolicyname         =   "EVBikes-dev-S3-Policy"
kmsmanagedpolicyname        =   "EVBikes-dev-KMS-Policy"
bastionhostpolicyname       =   "EVBikes-devsit-BastionHost-Managed-Policy"

#### S3 ####
bucketS3                    =   "804-EVBikes-dev-bucket"
bucketJenkins               =   "804-EVBikes-dev-jenkins-bucket"