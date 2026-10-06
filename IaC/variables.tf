variable "region" {
  type        = string
  description = "Regiao da AWS"
  default     = "us-east-1"
}

variable "project_name" {
  type        = string
  description = "Nome do projeto, usado nos nomes dos recursos"
  default     = "aws-lambda-springboot-api"
}

variable "environment" {
  type        = string
  description = "Ambiente (dev, hml, prd)"
  default     = "dev"
}

variable "lambda_handler" {
  type        = string
  description = "Handler generico do Serverless Java Container para Spring Boot 3"
  default     = "com.amazonaws.serverless.proxy.spring.SpringDelegatingLambdaContainerHandler"
}

variable "main_class" {
  type        = string
  description = "Classe principal da aplicacao Spring Boot"
  default     = "com.jurahein.api.Application"
}

variable "lambda_memory_size" {
  type        = number
  description = "Memoria do Lambda em MB"
  default     = 512
}

variable "lambda_timeout" {
  type        = number
  description = "Timeout do Lambda em segundos"
  default     = 30
}

variable "log_retention_days" {
  type        = number
  description = "Retencao dos logs no CloudWatch"
  default     = 7
}
