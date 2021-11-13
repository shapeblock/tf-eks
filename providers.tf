terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    restapi = {
      source = "gavinbunney/restapi"
      version = "1.15.4"
      uri                  = var.sb_url
      debug                = true
      write_returns_object = true

      headers = {
        X-Internal-Client = "abc123"
        Authorization = "5up3r53Cr3+123$"
        "Content-Type" = "application/json"
      }
    }    
  }
}

data "aws_eks_cluster" "cluster" {
  name = module.eks_cluster.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks_cluster.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}


provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}

