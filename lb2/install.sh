curl -o iam-policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json
aws iam create-policy     --policy-name AWSLoadBalancerControllerIAMPolicy     --policy-document file://iam-policy.json
eksctl utils associate-iam-oidc-provider   --region  eu-west-1 --cluster mycluster1  --approve
eksctl create iamserviceaccount --cluster mycluster1 --namespace=kube-system --name=aws-load-balancer-controller --attach-policy-arn=arn:aws:iam::566972129213:policy/AWSLoadBalancerControllerIAMPolicy --approve
helm repo add eks https://aws.github.io/eks-charts
kubectl apply -k "github.com/aws/eks-charts/stable/aws-load-balancer-controller//crds?ref=master"
helm upgrade -i aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=mycluster1 --set serviceAccount.create=false --set serviceAccount.name=aws-load-balancer-controller