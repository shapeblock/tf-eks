output "host" {
  value = data.aws_eks_cluster.cluster.endpoint
}

