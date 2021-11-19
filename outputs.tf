data "aws_eks_cluster" "cluster" {
  name = module.eks_cluster.cluster_id
}

output "host" {
  value = data.aws_eks_cluster.cluster.endpoint
}

