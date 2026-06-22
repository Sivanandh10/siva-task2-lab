# Chapter 1 - Find the Evidence

> Two pieces of evidence are hidden in the system. Find them both.

---

## Your tools for this chapter

| Command | Purpose |
|---------|---------|
| `find` | Search for files by name, size, or type |
| `du -b` | Show file size in bytes |
| `sort -rn` | Sort numerically, largest first |
| `awk` | Extract specific columns from output |

---

## Part 1 - The hidden file

Hidden files in Linux start with a dot and are invisible to a normal `ls`. Use `find` to locate them:

    find /root/case -name '.*' -type f

You will see `/root/case/data/.secret` in the output. Copy its contents into `found.txt`:

    cat /root/case/data/.secret > /root/case/found.txt

Verify it:

    cat /root/case/found.txt

---

## Part 2 - The largest file

Find the biggest file in the case directory and save its full path:

    find /root/case -type f -exec du -b {} + | sort -rn | head -1 | awk '{print $2}' > /root/case/biggest.txt

Verify it:

    cat /root/case/biggest.txt

You should see the path to `bigfile.bin`.

---

When both files exist, click **Check**. Both conditions must pass to continue.

<instruqt-task id="find_files"></instruqt-task>