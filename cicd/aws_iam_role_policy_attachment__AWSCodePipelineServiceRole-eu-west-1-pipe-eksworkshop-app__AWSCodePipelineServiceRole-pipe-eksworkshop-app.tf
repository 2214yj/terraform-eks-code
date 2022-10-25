# IAM 역할에 관리형 IAM 정책 연결
resource "aws_iam_role_policy_attachment" "AWSCodePipelineServiceRole-pipe-eksworkshop-app__AWSCodePipelineServiceRole-pipe-eksworkshop-app" {
  # policy_arn (필수) - 적용하려는 정책의 ARN
  policy_arn = aws_iam_policy.AWSCodePipelineServiceRole-pipe-eksworkshop-app.arn
  # role (필수) - 정책을 적용해야 하는 IAM 역할의 이름
  role       = aws_iam_role.AWSCodePipelineServiceRole-pipe-eksworkshop-app.id
}
