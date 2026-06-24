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
# Case Dashboard server on port 8080
cat > /root/dashboard.py << 'PYEOF'
import http.server, os, html

def read(f):
    try:
        return open(f).read().strip()
    except:
        return "Not yet found"

class Handler(http.server.BaseHTTPRequestHandler):
    def log_message(self, *a): pass
    def do_GET(self):
        findings = {
            "Secret File": read("/root/case/found.txt"),
            "Largest File": read("/root/case/biggest.txt"),
            "File Permissions": read("/root/case/locked.txt") and "Fixed (600)" or "Not fixed",
            "Error Count": read("/root/case/error_count.txt"),
            "Top IP": read("/root/case/top_ip.txt"),
        }
        rows = ""
        for k, v in findings.items():
            status = "found" if v != "Not yet found" else "pending"
            rows += f'<tr class="{status}"><td>{html.escape(k)}</td><td>{html.escape(str(v))}</td></tr>'
        page = f"""<!DOCTYPE html>
<html><head><title>Case Dashboard</title>
<meta http-equiv="refresh" content="5">
<style>
body{{background:#0d1117;color:#c9d1d9;font-family:monospace;padding:24px;margin:0}}
h1{{color:#58a6ff;border-bottom:1px solid #30363d;padding-bottom:12px;margin-bottom:20px}}
table{{width:100%;border-collapse:collapse}}
th{{background:#161b22;padding:12px;text-align:left;color:#8b949e;font-size:12px;letter-spacing:.05em;text-transform:uppercase}}
td{{padding:12px;border-bottom:1px solid #21262d}}
tr.found td:first-child{{color:#3fb950}}
tr.pending td:first-child{{color:#f85149}}
tr.found td:last-child{{color:#c9d1d9}}
tr.pending td:last-child{{color:#6e7681;font-style:italic}}
.badge{{background:#238636;color:#fff;padding:3px 10px;border-radius:20px;font-size:11px;margin-left:8px}}
.note{{color:#8b949e;font-size:12px;margin-top:16px}}
</style></head>
<body>
<h1>🔍 Case Dashboard <span class="badge">Live</span></h1>
<table><tr><th>Evidence</th><th>Finding</th></tr>{rows}</table>
<p class="note">Auto-refreshes every 5 seconds as you complete tasks</p>
</body></html>"""
        self.send_response(200)
        self.send_header("Content-type","text/html")
        self.end_headers()
        self.wfile.write(page.encode())

http.server.HTTPServer(("0.0.0.0", 8080), Handler).serve_forever()
PYEOF

nohup python3 /root/dashboard.py > /var/log/dashboard.log 2>&1 &