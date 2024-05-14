# Account nonprod(Prod).
provider "aws" {
  region = "ap-southeast-1"
  allowed_account_ids = ["080294233143"] # Need to fix Account for protect deployment accross account, if not terraform cloud can use access key find every aws account
}
