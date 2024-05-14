# Account kbtg-shareInfra Singapore region.
provider "aws" {
  alias = "ShareInfra"

  region = "ap-southeast-1"
  allowed_account_ids = ["166643700627"] # Need to fix Account for protect deployment accross account, if not terraform cloud can use access key find every aws account

  access_key = var.AWS_ACCESS_KEY_ID_SHAREINFRANONPROD
  secret_key = var.AWS_SECRET_ACCESS_KEY_SHAREINFRANONPROD
}

# Account kbtg-shareInfra Virginia region.
provider "aws" {
  alias = "ShareInfra-virginia"

  region = "us-east-1"
  allowed_account_ids = ["166643700627"] # Need to fix Account for protect deployment accross account, if not terraform cloud can use access key find every aws account

  access_key = var.AWS_ACCESS_KEY_ID_SHAREINFRANONPROD
  secret_key = var.AWS_SECRET_ACCESS_KEY_SHAREINFRANONPROD
}