# Nodes readonly access role
resource "kubernetes_cluster_role" "reader_nodes" {
  metadata {
    name = "reader-nodes"
  }

  rule {
    api_groups = [""]
    resources = [
      "nodes",
    ]
    verbs = [
      "get",
      "list",
      "watch"
    ]
  }

}

resource "kubernetes_cluster_role_binding" "reader_nodes" {
  metadata {
    name = "reader-nodes"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.reader_nodes.metadata[0].name
  }
  subject {
    kind      = "Group"
    name      = "system:authenticated"
    api_group = "rbac.authorization.k8s.io"
  }
}

//read-only access to all resources

resource "kubernetes_role" "reader-access" {
  metadata {
    name = "reader-access"
    namespace = "azure-vote"
  }

  rule {
    api_groups = ["*"]
    resources = [
      "pods",
    ]
    verbs = [
      "delete"
    ]
  }

  rule {
    api_groups = [""]
    resources = ["*"]
    verbs = ["*"]
  }

  rule {
    api_groups = ["extensions"]
    resources = ["*"]
    verbs = ["*"]
  }

}

resource "kubernetes_role_binding" "reader-access" {
  metadata {
    name = "reader-access"
    namespace = "azure-vote"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_role.reader-access.metadata[0].name

  }
  subject {
    kind      = "Group"
    name      = "AKS-Devs"
    api_group = "rbac.authorization.k8s.io"
  }
}