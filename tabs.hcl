resource "terminal" "shell" {
  target = resource.container.workstation
  shell  = "/bin/bash"
}

resource "editor" "code" {
  workspace "evidence" {
    directory = "/root/case"
    target    = resource.container.workstation
  }
}

resource "service" "dashboard" {
  target = resource.container.workstation
  port   = 8080
  path   = "/"
}

resource "external_website" "manpages" {
  url = "https://man7.org/linux/man-pages/"
}
