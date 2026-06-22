resource "lab" "siva_task2_lab" {
  title       = "Linux File Detective"
  description = "Investigate a compromised Linux system using find, grep, pipes, and permissions."
  layout      = resource.layout.two_column

  settings {
    timelimit {
      duration   = "60m"
      show_timer = true
    }
  }

  content {
    chapter "investigation" {
      title = "The Investigation"

      page "briefing" {
        reference = resource.page.briefing
      }
      page "find_files" {
        reference = resource.page.find_files
      }
      page "permissions" {
        reference = resource.page.permissions
      }
      page "analyze_logs" {
        reference = resource.page.analyze_logs
      }
    }
  }
}
