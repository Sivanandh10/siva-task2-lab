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
