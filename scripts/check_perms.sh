#!/bin/bash
perms=$(stat -c '%a' /root/case/locked.txt)
[ "$perms" = "600" ]
