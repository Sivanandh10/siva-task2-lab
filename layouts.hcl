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
  }
}
