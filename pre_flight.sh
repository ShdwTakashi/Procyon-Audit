
# A. Scan for open ports on the gateway (Router Audit)
GATEWAY=$(ip route | grep default | awk '{print $3}')
if nmap -p 23,80,8080 $GATEWAY | grep -q "open"; then
    echo "[!] Router management ports are exposed!"
fi

# B. Scan for suspicious autostart entries
if [ $(find /etc/xdg/autostart -mtime -2 | wc -l) -gt 0 ]; then
    echo "[!] Recent changes in autostart directories."
fi

# C. OS Integrity
if [ $(uname -a | grep -c "2026") -eq 0 ]; then
    echo "[!] Kernel appears outdated; potential for known exploits."
fi