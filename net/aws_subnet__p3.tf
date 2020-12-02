# File generated by aws2tf see https://github.com/aws-samples/aws2tf
# aws_subnet.subnet-p3:
resource "aws_subnet" "subnet-p3" {
  assign_ipv6_address_on_creation = false
  availability_zone               = "eu-west-1c"
  cidr_block                      = "10.0.3.0/24"
  map_public_ip_on_launch         = false
  tags = {
    "Name"                                        = "Private3"
 #   "alpha.eksctl.io/cluster-name"                = "mycluster1"
 #   "alpha.eksctl.io/eksctl-version"              = "0.29.2"
 #   "eksctl.cluster.k8s.io/v1alpha1/cluster-name" = "mycluster1"
    "kubernetes.io/cluster/mycluster1"            = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
    "workshop" = "subnet-p3"
  }
  vpc_id = aws_vpc.vpc-mycluster1.id

  timeouts {}
}

output "sub-priv3" {
  value = aws_subnet.subnet-p3.id
}