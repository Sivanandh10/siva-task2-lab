# Find the Evidence

> Two pieces of evidence are hidden in the system. Find them both.

---

## Part 1 - The hidden file

Hidden files start with a dot. Search the case data for them:

    find /root/case -name '.*' -type f

Once you find the .secret file, copy its contents into /root/case/found.txt:

    cat /root/case/data/.secret > /root/case/found.txt

---

## Part 2 - The largest file

Find the biggest file in the case directory and save its path:

    find /root/case -type f -exec du -b {} + | sort -rn | head -1 | awk '{print $2}' > /root/case/biggest.txt

---

When both files are created, click **Check**. Both conditions must pass.

<instruqt-task id="find_files"></instruqt-task>
