# IAM 사용자를 제공
resource "aws_iam_user" "git-user" {
  # name- (필수) 사용자의 이름
  name = "git-user"


  tags = {
    workshop = "eks-cicd"
  }
}


# IAM 사용자에게 관리형 IAM 정책 연결
resource "aws_iam_user_policy_attachment" "git-attach" {
  # user (필수) - 정책을 적용해야 하는 사용자
  user       = aws_iam_user.git-user.name
  # policy_arn (필수) - 적용하려는 정책의 ARN
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeCommitPowerUser"
}
