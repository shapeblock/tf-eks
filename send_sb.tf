provider "restapi" {
  uri                  = var.sb_url
  write_returns_object = true
  headers = {
    X-Internal-Client = "abc123"
    Authorization = "5up3r53Cr3+123$"
    "Content-Type" = "application/json"
  }
}


resource "restapi_object" "sa_credentials" {
  path = "/clusters/da93036a-f43a-4dce-8dc8-55aff17d1201/ingress-info"
  data = jsonencode({
      "foo" : "bar",
      "baz": "${var.cluster_name}"
      })
}