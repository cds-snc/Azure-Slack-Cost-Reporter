# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "s3" {
    bucket         = "azure-reporting-tf"
    dynamodb_table = "terraform-state-lock-dynamo"
    encrypt        = true
    key            = "./terraform.tfstate"
    region         = "ca-central-1"
  }
}