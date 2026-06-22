resource "page" "briefing" {
  title = "Case Briefing"
  file  = "instructions/briefing.md"
}

resource "page" "find_files" {
  title = "Find the Evidence"
  file  = "instructions/find_files.md"
  activities = [resource.task.find_files]
}

resource "page" "permissions" {
  title = "Unlock the File"
  file  = "instructions/permissions.md"
  activities = [resource.task.permissions]
}

resource "page" "analyze_logs" {
  title = "Analyze the Logs"
  file  = "instructions/analyze_logs.md"
  activities = [resource.task.analyze_logs]
}
