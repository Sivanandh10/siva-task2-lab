#!/bin/bash
mkdir -p /root/case
mkdir -p /root/case/data
mkdir -p /root/case/logs
echo 'classified intel: operation nightfall' > /root/case/data/.secret
head -c 500000 /dev/zero > /root/case/data/bigfile.bin
echo 'small' > /root/case/data/note.txt
echo 'locked evidence' > /root/case/locked.txt
chmod 000 /root/case/locked.txt
printf '%s\n' '10.0.0.5 INFO login' '10.0.0.9 ERROR failed' '10.0.0.5 ERROR timeout' '10.0.0.5 INFO ok' '10.0.0.9 ERROR crash' > /root/case/logs/access.log
