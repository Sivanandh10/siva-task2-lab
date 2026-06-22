resource "lab" "siva_task2_lab" {
  title       = "Linux File Detective"
  description = "Investigate a Linux system using find, grep, pipes, and permissions."

  layout = resource.layout.two_column

  settings {
    timelimit {
      duration   = "60m"
      show_timer = true
    }
  }
}
