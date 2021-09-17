data "aws_iam_policy_document" "lambda-assume-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda" {
  name = "LambdaAPIRole"
  assume_role_policy = data.aws_iam_policy_document.lambda-assume-policy.json

  inline_policy {
    name = "lambda_api_policy"
    policy = jsonencode({
      Statement = [
        {
          Action = [
            "logs:*",
            "ec2:*"
          ]
          Effect = "Allow"
          Resource = "*"
        }
      ]
    })
  }
}

# data "aws_iam_policy_document" "ecs-assume-policy" {
#   statement {
#     actions = ["sts:AssumeRole"]
# 
#     principals {
#       type = "Service"
#       identifiers = ["ecs-tasks.amazonaws.com"]
#     }
#   }
# }
# 
# resource "aws_iam_role" "ecs" {
#   name                  = "ECSTaskServiceRole"
#   assume_role_policy    = data.aws_iam_policy_document.ecs-assume-policy.json
#   
#   inline_policy {
#     name           = "ecs_iam_policy"
#     policy         = jsonencode({
#       Statement    = [
#         {
#           Action   = [
#             "ecr:*",
#             "ecs:*",
#             "ssm:*",
#             "logs:*",
#             "route53:*",
#           ]
#           Effect   = "Allow"
#           Resource = "*"
#         },
#       ]
#     })
#   }
# }
# 
# resource "aws_iam_role_policy_attachment" "ecs-attachment" {
#   role          = aws_iam_role.ecs.name
#   policy_arn    = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
# }
