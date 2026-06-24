resource "network" "main" {
  subnet = "10.0.210.0/24"
}

resource "container" "workstation" {
  image {
    name = "ubuntu:22.04"
  }
  network {
    id = resource.network.main.meta.id
  }
  port {
    local = 8080
  }
}
