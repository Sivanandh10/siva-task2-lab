# Chapter 3 - Analyze the Logs

> The access log holds the final clues. Use pipes and jq to extract the answers.

---

## Your tools for this chapter

| Command | Purpose |
|---------|---------|
| `grep -c` | Count matching lines |
| `awk` | Extract a specific column |
| `sort` | Sort lines alphabetically or numerically |
| `uniq -c` | Count duplicate lines |
| `jq` | Parse and query JSON files |

---

## Step 1 - View the logs

    cat /root/case/logs/access.log

    cat /root/case/logs/events.json

---

## Step 2 - Parse JSON with jq

Use jq to extract all failed events from the JSON log:

    jq 'select(.status != "success")' /root/case/logs/events.json

Extract just the IPs involved in errors:

    jq -r 'select(.status == "error" or .status == "failed") | .ip' /root/case/logs/events.json

---

## Part 1 - Count the errors

    grep -c ERROR /root/case/logs/access.log > /root/case/error_count.txt

    cat /root/case/error_count.txt

---

## Part 2 - Find the top attacker IP

    awk '{print $1}' /root/case/logs/access.log | sort | uniq -c | sort -rn | head -1 | awk '{print $2}' > /root/case/top_ip.txt

    cat /root/case/top_ip.txt

Cross-reference with the suspects list:

    grep $(cat /root/case/top_ip.txt) /root/case/suspects/known_ips.txt

When both files are created, click **Check** to close the case.

<instruqt-task id="analyze_logs"></instruqt-task>