# Analyze the Logs

> The access log holds the final clues. Use pipes to extract them.

---

## Part 1 - Count the errors

Count how many lines contain ERROR and save the number:

    grep -c ERROR /root/case/logs/access.log > /root/case/error_count.txt

---

## Part 2 - Find the top IP

The attacker's IP appears most often. Extract it using a pipe chain:

    awk '{print $1}' /root/case/logs/access.log | sort | uniq -c | sort -rn | head -1 | awk '{print $2}' > /root/case/top_ip.txt

---

This chain: pulls the first column (IP), sorts them, counts duplicates, sorts by count, takes the top one, and prints just the IP.

When both files are created, click **Check** to close the case.

<instruqt-task id="analyze_logs"></instruqt-task>
