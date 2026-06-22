# Unlock the File

> A key evidence file has been locked with no permissions. Restore access.

---

## Check the current permissions

    ls -l /root/case/locked.txt

You will see ---------- meaning no one can read it.

---

## Fix it

Set the file so the owner can read and write it, but no one else (mode 600):

    chmod 600 /root/case/locked.txt

Verify:

    ls -l /root/case/locked.txt

You should now see -rw-------.

Then click **Check**.

<instruqt-task id="permissions"></instruqt-task>
