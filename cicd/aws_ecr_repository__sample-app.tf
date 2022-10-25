resource "aws_ecr_repository" "sample-app" {
   # 저장소의 이름
  name                 = "sample-app"

  # 이미지 태그를 덮어쓸 수 있는지 -> 덮어 쓸 수 있음
  image_tag_mutability = "MUTABLE"

  # true인 경우 이미지가 포함되어 있어도 저장소를 삭제
  force_delete = true

  # 리포지토리에 대한 이미지 스캔 구성을 정의하는 구성 블록
  image_scanning_configuration {
     # 이미지가 리포지토리에 푸시된 후 스캔되는지(true)
      # 스캔을 통해 도커 이미지의 취약점 검사를 수행
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "karpenter-webhook" {
   # 저장소의 이름
  name                 = "karpenter/webhook"

  # 이미지 태그를 덮어쓸 수 있는지 -> 덮어 쓸 수 있음
  image_tag_mutability = "MUTABLE"

  # true인 경우 이미지가 포함되어 있어도 저장소를 삭제
  force_delete = true

  # 리포지토리에 대한 이미지 스캔 구성을 정의하는 구성 블록
  image_scanning_configuration {
     # 이미지가 리포지토리에 푸시된 후 스캔되는지(true)
        # 스캔을 통해 도커 이미지의 취약점 검사를 수행
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "karpenter-controller" {
   # 저장소의 이름
  name                 = "karpenter/controller"

  # 이미지 태그를 덮어쓸 수 있는지 -> 덮어 쓸 수 있음
  image_tag_mutability = "MUTABLE"

  # true인 경우 이미지가 포함되어 있어도 저장소를 삭제
  force_delete = true

  # 리포지토리에 대한 이미지 스캔 구성을 정의하는 구성 블록
  image_scanning_configuration {
   # 이미지가 리포지토리에 푸시된 후 스캔되는지(true)
      # 스캔을 통해 도커 이미지의 취약점 검사를 수행
    scan_on_push = true
  }
}


resource "aws_ecr_repository" "pause" {
   # 저장소의 이름
  name                 = "pause"

  # 이미지 태그를 덮어쓸 수 있는지 -> 덮어 쓸 수 있음
  image_tag_mutability = "MUTABLE"

  # true인 경우 이미지가 포함되어 있어도 저장소를 삭제
  force_delete = true

  # 리포지토리에 대한 이미지 스캔 구성을 정의하는 구성 블록
  image_scanning_configuration {
     # 이미지가 리포지토리에 푸시된 후 스캔되는지(true)
        # 스캔을 통해 도커 이미지의 취약점 검사를 수행
    scan_on_push = true
  }
}