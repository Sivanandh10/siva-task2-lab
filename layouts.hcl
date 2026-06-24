resource "layout" "two_column" {
  column {
    width = "50"
    instructions {}
  }
  column {
    width = "50"
    tab "terminal" {
      title  = "Terminal"
      target = resource.terminal.shell
      active = true
    }
    tab "editor" {
      title  = "Evidence Files"
      target = resource.editor.code
    }
    tab "dashboard" {
      title  = "Case Dashboard"
      target = resource.service.dashboard
    }
    tab "manpages" {
      title  = "Man Pages"
      target = resource.external_website.manpages
    }
  }
}
