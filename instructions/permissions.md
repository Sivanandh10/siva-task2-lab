# Chapter 2 - Unlock the File

> A key evidence file has been locked with no permissions. Restore access so you can read it.

---

## Your tools for this chapter

| Command | Purpose |
|---------|---------|
| `ls -l` | Show file permissions |
| `chmod` | Change file permissions |
| `stat -c '%a'` | Show permissions as a number |

---

## Step 1 - Check the current permissions

    ls -l /root/case/locked.txt

You will see `----------` — this means nobody can read, write, or execute it.

---

## Step 2 - Understand permission modes

Linux permissions use a 3-digit number:

| Mode | Meaning |
|------|---------|
| `600` | Owner can read and write. Nobody else can access it. |
| `644` | Owner can read and write. Others can only read. |
| `755` | Owner has full access. Others can read and execute. |

---

## Step 3 - Fix the permissions

Set the file to mode 600 so only the owner can read and write it:

    chmod 600 /root/case/locked.txt

Verify it worked:

    ls -l /root/case/locked.txt

You should now see `-rw-------`. Then click **Check**.

<instruqt-task id="permissions"></instruqt-task>