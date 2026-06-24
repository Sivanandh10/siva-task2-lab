#!/bin/bash
count=$(cat /root/case/error_count.txt)
[ "$count" = "5" ]
