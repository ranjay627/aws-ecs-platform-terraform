data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = []

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-github-oidc"
    }
  )
}

data "aws_iam_policy_document" "github_actions_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type = "Federated"

      identifiers = [
        aws_iam_openid_connect_provider.github.arn
      ]
    }

    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"

      values = [
        "sts.amazonaws.com"
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"

      values = [
        "repo:${var.github_repository}:ref:refs/heads/${var.github_branch}"
      ]
    }
  }
}

resource "aws_iam_role" "github_actions" {
  name               = "${var.name}-github-actions"
  assume_role_policy = data.aws_iam_policy_document.github_actions_assume_role.json

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-github-actions"
    }
  )
}

data "aws_iam_policy_document" "github_actions_deploy" {
  statement {
    sid    = "ECRAuthorization"
    effect = "Allow"

    actions = [
      "ecr:GetAuthorizationToken"
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid    = "ECRPush"
    effect = "Allow"

    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:CompleteLayerUpload",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart"
    ]

    resources = [
      var.ecr_repository_arn
    ]
  }

  statement {
    sid    = "ECRRead"
    effect = "Allow"

    actions = [
      "ecr:BatchGetImage",
      "ecr:DescribeImages"
    ]

    resources = [
      var.ecr_repository_arn
    ]
  }

  statement {
    sid    = "ECSDeployment"
    effect = "Allow"

    actions = [
      "ecs:DescribeServices",
      "ecs:DescribeTaskDefinition",
      "ecs:RegisterTaskDefinition",
      "ecs:UpdateService"
    ]

    resources = [
      var.ecs_cluster_arn,
      var.ecs_service_arn,
      "${var.ecs_cluster_arn}/*"
    ]
  }

  statement {
    sid    = "PassECSTaskRoles"
    effect = "Allow"

    actions = [
      "iam:PassRole"
    ]

    resources = [
      "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:role/${var.name}-ecs-task",
      "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:role/${var.name}-ecs-task-execution"
    ]
  }
}

resource "aws_iam_role_policy" "github_actions_deploy" {
  name   = "${var.name}-github-actions-deploy"
  role   = aws_iam_role.github_actions.id
  policy = data.aws_iam_policy_document.github_actions_deploy.json
}