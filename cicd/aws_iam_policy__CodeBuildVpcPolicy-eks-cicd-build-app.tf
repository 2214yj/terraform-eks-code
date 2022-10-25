# IAM 정책을 제공
# aws_iam_policy.CodeBuildVpcPolicy-eks-cicd-build-app:
resource "aws_iam_policy" "CodeBuildVpcPolicy-eks-cicd-build-app" {
  # description- (선택 사항, Forces new resource) IAM 정책에 대한 설명입니다.
  description = "Policy used in trust relationship with CodeBuild"

  # name- (선택 사항, 새 리소스를 강제 실행) 정책의 이름입니다. 생략하면 Terraform은 임의의 고유한 이름을 할당합니다.
  name        = "CodeBuildVpcPolicy-eks-cicd-build-app"

  # path- (선택 사항, 기본 "/") 정책을 생성할 경로입니다. 자세한 내용은 IAM 식별자 를 참조하십시오.
  path        = "/service-role/"

  # policy- (필수) 정책 문서. 이것은 JSON 형식의 문자열입니다.
  policy = jsonencode(
    {
      Statement = [
        {
          Action = [
            "ec2:CreateNetworkInterface",
            "ec2:DescribeDhcpOptions",
            "ec2:DescribeNetworkInterfaces",
            "ec2:DeleteNetworkInterface",
            "ec2:DescribeSubnets",
            "ec2:DescribeSecurityGroups",
            "ec2:DescribeVpcs",
          ]
          Effect   = "Allow"
          Resource = "*"
        },
        {
          Action = [
            "ec2:CreateNetworkInterfacePermission",
          ]
          Condition = {
            StringEquals = {
              "ec2:AuthorizedService" = "codebuild.amazonaws.com"
              "ec2:Subnet" = [
                format("arn:aws:ec2:%s:%s:subnet/subnet-00cc72ac5b0b79dd4",data.aws_caller_identity.current.account_id, data.aws_region.current.name),

              ]
            }
          }
          Effect   = "Allow"
          Resource = format("arn:aws:ec2:%s:%s:network-interface/*",data.aws_caller_identity.current.account_id, data.aws_region.current.name),

        },
      ]
      Version = "2012-10-17"
    }
  )
}
