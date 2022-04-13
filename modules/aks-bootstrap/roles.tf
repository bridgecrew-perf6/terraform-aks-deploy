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

resource "kubernetes_cluster_role" "read-only" {
  metadata {
    name = "read-only-access"
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
    verbs = [
      "get",
      "list",
      "watch"
    ]
  }

}

resource "kubernetes_role_binding" "read-only" {
  metadata {
    name = "read-only"
    namespace = "azure-vote"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.read-only.metadata[0].name

  }
  subject {
    kind      = "Group"
    name      = "system:authenticated"
    api_group = "rbac.authorization.k8s.io"
  }
}