resource "task" "find_files" {
  description = "Locate the hidden evidence"

  config {
    target = resource.container.workstation
  }

  condition "found_secret" {
    description = "Copy the hidden .secret file to /root/case/found.txt"
    setup {
      script = "scripts/setup.sh"
    }
    check {
      script = "scripts/check_found.sh"
    }
  }

  condition "found_large" {
    description = "Find the largest file and save its path to /root/case/biggest.txt"
    check {
      script = "scripts/check_biggest.sh"
    }
  }
}

resource "task" "permissions" {
  description = "Fix the locked evidence file"

  config {
    target = resource.container.workstation
  }

  condition "perms_fixed" {
    description = "Make /root/case/locked.txt readable and writable by owner only (600)"
    check {
      script = "scripts/check_perms.sh"
    }
  }
}

resource "task" "analyze_logs" {
  description     = "Analyze the access log"
  success_message = "Case closed, Detective. You have mastered Linux investigation."

  config {
    target = resource.container.workstation
  }

  condition "counted_errors" {
    description = "Count ERROR lines in access.log and save the number to /root/case/error_count.txt"
    check {
      script = "scripts/check_errors.sh"
    }
  }

  condition "found_ip" {
    description = "Extract the most frequent IP from access.log to /root/case/top_ip.txt"
    check {
      script = "scripts/check_ip.sh"
    }
  }
}
