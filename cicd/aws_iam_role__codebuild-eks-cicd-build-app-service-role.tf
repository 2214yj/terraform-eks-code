
# aws_iam_role.codebuild-eks-cicd-build-app-service-role:
# IAM 역할을 제공
resource "aws_iam_role" "codebuild-eks-cicd-build-app-service-role" {

  # assume_role_policy- (필수) 엔터티가 역할을 맡을 수 있는 권한을 부여하는 정책입니다.
  assume_role_policy = jsonencode(
    {
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Principal = {
            Service = "codebuild.amazonaws.com"
          }
        },
      ]
      Version = "2012-10-17"
    }
  )

  # force_detach_policies- (선택 사항) 역할을 제거하기 전에 역할에 있는 정책을 강제로 분리할지 여부입니다. 기본값은 false입니다.
  force_detach_policies = false

  # max_session_duration- (선택 사항) 지정된 역할에 대해 설정하려는 최대 세션 기간(초)입니다. 이 설정의 값을 지정하지 않으면 기본 최대값인 1시간이 적용됩니다. 이 설정은 1시간에서 12시간 사이의 값을 가질 수 있습니다.
  max_session_duration  = 3600

  # name- (선택 사항, 새 리소스 강제 적용) 역할의 이름입니다. 생략하면 Terraform은 임의의 고유한 이름을 할당합니다. 자세한 내용은 IAM 식별자 를 참조하십시오.
  name                  = "codebuild-eks-cicd-build-app-service-role"

  # path- (선택 사항) 역할의 경로입니다. 자세한 내용은 IAM 식별자 를 참조하십시오.
  path                  = "/service-role/"
  tags                  = {}
}
