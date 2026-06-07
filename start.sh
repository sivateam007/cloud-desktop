#!/bin/bash

rm -f /tmp/.X99-lock

Xvfb :99 -screen 0 1280x720x16 &
sleep 2

export DISPLAY=:99
openbox-session &
sleep 2

mkdir -p /home/user/.vnc
x11vnc -storepasswd "$VNC_PW" /home/user/.vnc/passwd 2>/dev/null
x11vnc -display :99 -forever -shared -rfbport 5901 -rfbauth /home/user/.vnc/passwd -bg -o /tmp/x11vnc.log 2>/dev/null
sleep 1

NOVNC_DIR=$(find /usr -name "vnc.html" -path "*/novnc/*" -exec dirname {} \; 2>/dev/null | head -1)
if [ -z "$NOVNC_DIR" ]; then
    NOVNC_DIR=/usr/share/novnc
fi
/usr/bin/websockify --web "$NOVNC_DIR" 8080 localhost:5901 &
sleep 2

su - user -c "/cloud-mount.sh" &

echo "READY"

wait
