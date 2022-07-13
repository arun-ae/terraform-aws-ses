provider "aws" {
  region = var.aws_primary_region
}



# provider "aws" {
#   alias  = "gbst"
#   region = var.aws_primary_region
#   #   assume_role {
#   #   role_arn = ""
#   # }
# }
