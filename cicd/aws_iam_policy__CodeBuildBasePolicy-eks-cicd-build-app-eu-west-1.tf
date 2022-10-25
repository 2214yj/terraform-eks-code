# IAM 정책을 제공
# aws_iam_policy.CodeBuildBasePolicy-eks-cicd-build-app:
resource "aws_iam_policy" "CodeBuildBasePolicy-eks-cicd-build-app" {
  # description- (선택 사항, Forces new resource) IAM 정책에 대한 설명입니다.
  description = "Policy used in trust relationship with CodeBuild v0.4"

  # name- (선택 사항, 새 리소스를 강제 실행) 정책의 이름입니다. 생략하면 Terraform은 임의의 고유한 이름을 할당합니다.
  name        = "CodeBuildBasePolicy-eks-cicd-build-app"

  # path- (선택 사항, 기본 "/") 정책을 생성할 경로입니다. 자세한 내용은 IAM 식별자 를 참조하십시오.
  path        = "/service-role/"

  # policy- (필수) 정책 문서. 이것은 JSON 형식의 문자열입니다.
  policy = jsonencode(
    {
      Statement = [
        {
          Action = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents",
          ]
          Effect = "Allow"
          Resource = [
             format("arn:aws:logs:%s:%s:log-group:/aws/codebuild/eks-cicd-build-app",data.aws_region.current.name,data.aws_caller_identity.current.account_id),
             format("arn:aws:logs:%s:%s:log-group:/aws/codebuild/eks-cicd-build-app:*", data.aws_region.current.name,data.aws_caller_identity.current.account_id)
          ]
        },
        {
          Action = [
            "s3:PutObject",
            "s3:GetObject",
            "s3:GetObjectVersion",
            "s3:GetBucketAcl",
            "s3:GetBucketLocation",
          ]
          Effect = "Allow"
          Resource = [
            format("arn:aws:s3:::codepipeline-%s-*",data.aws_region.current.name)
          ]
        },
        {
          Action = [
            "codecommit:GitPull",
          ]
          Effect = "Allow"
          Resource = [
            format("arn:aws:codecommit:%s:%s:Terraform-EKS", data.aws_region.current.name,data.aws_caller_identity.current.account_id),
          ]
        },
        {
          Action = [
            "codebuild:CreateReportGroup",
            "codebuild:CreateReport",
            "codebuild:UpdateReport",
            "codebuild:BatchPutTestCases",
            "codebuild:BatchPutCodeCoverages",
          ]
          Effect = "Allow"
          Resource = [
            #format("arn:aws:codebuild:%s:%s:report-group/eks-cicd-build-app-*",data.aws_caller_identity.current.account_id, data.aws_region.current.name),
            format("arn:aws:codebuild:%s:%s:report-group/eks-cicd-build-app-*",data.aws_region.current.name,data.aws_caller_identity.current.account_id),
          ]
        },
      ]
      Version = "2012-10-17"
    }
  )
}
