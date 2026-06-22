# Chapter 3 - Analyze the Logs

> The access log holds the final clues. Use pipes to extract the answers.

---

## Your tools for this chapter

| Command | Purpose |
|---------|---------|
| `grep -c` | Count matching lines |
| `awk` | Extract a specific column |
| `sort` | Sort lines alphabetically or numerically |
| `uniq -c` | Count duplicate lines |

---

## Step 1 - View the log first

    cat /root/case/logs/access.log

You will see lines like `10.0.0.5 INFO login` — each line has an IP, a level, and an event.

---

## Part 1 - Count the errors

Count how many lines contain ERROR and save just the number:

    grep -c ERROR /root/case/logs/access.log > /root/case/error_count.txt

Verify:

    cat /root/case/error_count.txt

---

## Part 2 - Find the top attacker IP

The attacker's IP appears most often. Use this pipe chain to extract it:

    awk '{print $1}' /root/case/logs/access.log | sort | uniq -c | sort -rn | head -1 | awk '{print $2}' > /root/case/top_ip.txt

What this does step by step:
- `awk '{print $1}'` — extracts the first column (IP addresses)
- `sort` — sorts them so duplicates are adjacent
- `uniq -c` — counts each unique IP
- `sort -rn` — sorts by count, highest first
- `head -1` — takes the top result
- `awk '{print $2}'` — extracts just the IP from the count line

Verify:

    cat /root/case/top_ip.txt

When both files are created, click **Check** to close the case.

<instruqt-task id="analyze_logs"></instruqt-task>