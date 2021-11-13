
resource "restapi_object" "sa_credentials" {
  path = "/clusters/da93036a-f43a-4dce-8dc8-55aff17d1201/ingress-info"
  data = jsonencode({
      "foo" : "bar",
      "baz": var.cluster_name
      })
}