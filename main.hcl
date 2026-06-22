resource "lab" "siva_task2_lab" {
  title       = "Linux File Detective"
  description = "Investigate a Linux system using find, grep, pipes, and permissions."

  layout = resource.layout.two_column

  page = [
    resource.page.briefing,
    resource.page.find_files,
    resource.page.permissions,
    resource.page.analyze_logs,
  ]

  settings {
    timelimit {
      duration   = "60m"
      show_timer = true
    }
  }
}
