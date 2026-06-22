#!/bin/bash
apt-get update -y
apt-get install -y curl jq net-tools iproute2 nmap dnsutils

mkdir -p /root/case/data
mkdir -p /root/case/logs
mkdir -p /root/case/suspects
mkdir -p /root/case/network

echo 'classified intel: operation nightfall' > /root/case/data/.secret
echo 'decoy file - not what you are looking for' > /root/case/data/decoy.txt
echo 'another decoy' > /root/case/data/readme.txt
head -c 500000 /dev/zero > /root/case/data/bigfile.bin
echo 'small note' > /root/case/data/note.txt

echo 'locked evidence - contains suspect identity' > /root/case/locked.txt
chmod 000 /root/case/locked.txt

printf '%s\n' \
  '10.0.0.5 INFO login' \
  '10.0.0.9 ERROR failed_auth' \
  '10.0.0.5 ERROR timeout' \
  '10.0.0.3 INFO browse' \
  '10.0.0.5 INFO upload' \
  '10.0.0.9 ERROR crash' \
  '10.0.0.5 ERROR exfiltration_attempt' \
  '10.0.0.3 INFO logout' \
  '10.0.0.5 INFO login' \
  '10.0.0.9 ERROR failed_auth' \
  > /root/case/logs/access.log

printf '%s\n' \
  '{"ip":"10.0.0.5","event":"login","status":"success"}' \
  '{"ip":"10.0.0.9","event":"auth","status":"failed"}' \
  '{"ip":"10.0.0.5","event":"upload","status":"success"}' \
  '{"ip":"10.0.0.9","event":"crash","status":"error"}' \
  '{"ip":"10.0.0.5","event":"exfil","status":"blocked"}' \
  > /root/case/logs/events.json

echo 'suspect_a: 10.0.0.9' > /root/case/suspects/known_ips.txt
echo 'suspect_b: 10.0.0.5' >> /root/case/suspects/known_ips.txt
echo 'suspect_c: 10.0.0.3' >> /root/case/suspects/known_ips.txt

ifconfig > /root/case/network/interfaces.txt
ip route > /root/case/network/routes.txt

echo 'CASE FILE: Operation Nightfall' > /root/case/README.txt
echo 'Opened: 2026-06-22' >> /root/case/README.txt
echo 'Status: ACTIVE INVESTIGATION' >> /root/case/README.txt