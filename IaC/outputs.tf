output "function_name" {
  description = "Nome da funcao Lambda (usado pelo deploy do codigo)"
  value       = aws_lambda_function.api.function_name
}

output "api_url" {
  description = "URL base da API"
  value       = aws_apigatewayv2_api.http.api_endpoint
}
