# IAM 역할에 관리형 IAM 정책 연결
resource "aws_iam_role_policy_attachment" "codebuild-eks-cicd-build-app-service-role__CodeBuildVpcPolicy-eks-cicd-build-app" {
  # policy_arn(필수) - 적용하려는 정책의 ARN
  policy_arn = aws_iam_policy.CodeBuildVpcPolicy-eks-cicd-build-app.arn
  # role (필수) - 정책을 적용해야 하는 IAM 역할의 이름
  role       = aws_iam_role.codebuild-eks-cicd-build-app-service-role.id
}
