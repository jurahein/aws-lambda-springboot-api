# Role do GitHub Actions para publicar o codigo no Lambda (menor privilegio)
# O provedor OIDC foi criado no bootstrap; aqui ele so e consultado.

variable "github_owner" {
  type        = string
  description = "Usuario ou organizacao dona do repositorio no GitHub"
  default     = "jurahein"
}

variable "github_repo" {
  type        = string
  description = "Nome do repositorio no GitHub"
  default     = "aws-lambda-springboot-api"
}

data "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"
}

data "aws_iam_policy_document" "github_deploy_trust" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [data.aws_iam_openid_connect_provider.github.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.github_owner}/${var.github_repo}:ref:refs/heads/main"]
    }
  }
}

resource "aws_iam_role" "github_deploy" {
  name               = "github-actions-lambda-deploy"
  assume_role_policy = data.aws_iam_policy_document.github_deploy_trust.json
}

data "aws_iam_policy_document" "github_deploy" {
  statement {
    sid = "PublishLambdaCode"
    actions = [
      "lambda:UpdateFunctionCode",
      "lambda:GetFunction",
      "lambda:GetFunctionConfiguration",
    ]
    resources = [aws_lambda_function.api.arn]
  }

  # Permite descobrir a URL da API no smoke test (ela muda se a infra for recriada)
  statement {
    sid       = "ListHttpApis"
    actions   = ["apigateway:GET"]
    resources = ["arn:aws:apigateway:${var.region}::/apis"]
  }
}

resource "aws_iam_role_policy" "github_deploy" {
  name   = "publish-lambda-code"
  role   = aws_iam_role.github_deploy.id
  policy = data.aws_iam_policy_document.github_deploy.json
}

output "github_deploy_role_arn" {
  description = "Role que o workflow de deploy assume via OIDC"
  value       = aws_iam_role.github_deploy.arn
}
