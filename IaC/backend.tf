# Valores literais para rodar da maquina local.
# Quando o workflow de Terraform for criado, estes valores viram tokens #{...}#.
terraform {
  backend "s3" {
    bucket       = "tfstate-360734035729-us-east-1"
    key          = "lambda-api/dev/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}
