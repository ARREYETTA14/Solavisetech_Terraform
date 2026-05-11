# # Below is Backend block
# terraform {
#   backend "s3" {
#     bucket = "tester-solly"
#     key = "website/prod/imbest.tfstate"
#     region = "sa-east-1"
#     dynamodb_table = "tester1"
#   }
# }