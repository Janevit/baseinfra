# Account nonprod(Prod).
provider "aws" {
  region = "ap-southeast-1"
  allowed_account_ids = ["080294233143"] # Need to fix Account for protect deployment accross account, if not terraform cloud can use access key find every aws account
}

provider "aws" {
  alias = "aws-virginia"
  region = "us-east-1"
  allowed_account_ids = ["080294233143"] # Need to fix Account for protect deployment accross account, if not terraform cloud can use access key find every aws account
}

# Account kbtg-shareInfra.
provider "aws" {
  alias = "ShareInfra"

  region = "ap-southeast-1"
  allowed_account_ids = ["166643700627"] # Need to fix Account for protect deployment accross account, if not terraform cloud can use access key find every aws account

  access_key = var.AWS_ACCESS_KEY_ID_SHAREINFRANONPROD
  secret_key = var.AWS_SECRET_ACCESS_KEY_SHAREINFRANONPROD
}

# Account kbtg-shareInfra.
provider "aws" {
  alias = "ShareInfra-virginia"

  region = "us-east-1"
  allowed_account_ids = ["166643700627"] # Need to fix Account for protect deployment accross account, if not terraform cloud can use access key find every aws account

  access_key = var.AWS_ACCESS_KEY_ID_SHAREINFRANONPROD
  secret_key = var.AWS_SECRET_ACCESS_KEY_SHAREINFRANONPROD
}

# Account kbtg-security.
provider "aws" {
  alias = "Security"

  region = "ap-southeast-1"
  allowed_account_ids = ["136728595638"] # Need to fix Account for protect deployment accross account, if not terraform cloud can use access key find every aws account

  access_key = var.AWS_ACCESS_KEY_ID_SECURITYNONPROD
  secret_key = var.AWS_SECRET_ACCESS_KEY_SECURITYNONPROD
}

## Use for generate public key for ker-pair
provider "tls" {}

