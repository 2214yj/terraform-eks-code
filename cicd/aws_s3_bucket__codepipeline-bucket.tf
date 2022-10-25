# 이미 생성되어있는 리소스를 가져와서 변수로 저장
data "external" "bucket_name" {
  program = ["bash", "get-bucket-name.sh"]
}

# 출력값
output "Name" {
  value = data.external.bucket_name.result.Name
}

# S3 버킷 리소스를 제공
resource "aws_s3_bucket" "codepipeline-bucket" {
  # bucket- (선택 사항, 새 리소스를 강제 실행) 버킷의 이름입니다.
  bucket = data.external.bucket_name.result.Name

  # hosted_zone_id- 이 버킷 리전 의 Route 53 호스팅 영역 ID 입니다.
  hosted_zone_id = "Z1BKCTXD74EZPE"
  tags           = {}

  # force_destroy- (선택 사항, 기본값: ) 모든 객체( 잠긴 객체false 포함)를 나타내는 부울 값은 버킷이 오류 없이 파괴될 수 있도록 버킷에서 삭제되어야 합니다. 이러한 개체는 복구할 수 없습니다 .
  force_destroy = false

}

# S3 버킷에서 버전 관리를 제어하기 위한 리소스를 제공
# 이 리소스를 삭제하면 연결된 S3 버킷의 버전 관리가 일시 중단되거나 연결된 S3 버킷이 버전이 지정되지 않은 경우 Terraform 상태에서 리소스가 제거됩니다.
resource "aws_s3_bucket_versioning" "codepipeline-bucket" {
  # Enable versioning so we can see the full revision history of our
  # state files

  # bucket- (필수, 강제 새 리소스) S3 버킷의 이름입니다.
  bucket = aws_s3_bucket.codepipeline-bucket.id

  # versioning_configuration- (필수) 버전 관리 매개변수에 대한 구성 블록
  versioning_configuration {
    # status- (필수) 버킷의 버전 관리 상태입니다. 유효한 값: Enabled, Suspended또는 Disabled. Disabled버전이 지정되지 않은 S3 버킷에 해당하는 리소스를 생성하거나 가져올 때만 사용해야 합니다.
    status = "Enabled"
  }
}

# S3 버킷 요청 결제 구성 리소스를 제공
resource "aws_s3_bucket_request_payment_configuration" "codepipeline-bucket" {
  # bucket- (필수, 새 리소스 강제 실행) 버킷의 이름입니다.
  bucket = aws_s3_bucket.codepipeline-bucket.id

  # payer- (필수) 다운로드 및 요청 수수료를 지불하는 사람을 지정합니다. 유효한 값: BucketOwner, Requester
  payer  = "BucketOwner"
}

# S3 버킷 ACL 리소스를 제공
resource "aws_s3_bucket_acl" "codepipeline-bucket" {
  # bucket- (필수, 새 리소스 강제 실행) 버킷의 이름
  bucket = aws_s3_bucket.codepipeline-bucket.id

  # acl- (선택 사항, Conflicts with access_control_policy) 버킷에 적용할 미리 준비된 ACL
  acl    = "private"
}

