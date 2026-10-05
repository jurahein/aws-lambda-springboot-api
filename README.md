# aws-lambda-springboot-api

API Spring Boot 3 (Java 21) preparada para rodar no AWS Lambda. Projeto de estudos.

## Endpoints

- `GET /hello`
- `GET /health`

## Build local

```bash
mvn -B verify
```

O jar para o Lambda sai em `target/aws-lambda-springboot-api.jar`.

## Configuracao no Lambda (etapas seguintes)

- Runtime: Java 21
- Handler: `com.amazonaws.serverless.proxy.spring.SpringDelegatingLambdaContainerHandler`
- Variavel de ambiente: `MAIN_CLASS=com.jurahein.api.Application`

## Pipeline (GitHub Actions)

Build e testes, SonarCloud, CodeQL, Gitleaks e revisao de dependencias em pull requests.
Segredo necessario no repositorio: `SONAR_TOKEN`.
