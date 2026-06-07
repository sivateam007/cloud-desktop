#!/bin/bash

rm -f /tmp/.X99-lock

echo "Starting Xvfb..."
Xvfb :99 -screen 0 1280x720x16 -nolisten tcp &
sleep 2

if [ ! -e /tmp/.X11-unix/X99 ]; then
    echo "Xvfb failed to start"
    exit 1
fi

export DISPLAY=:99

echo "Starting Openbox..."
openbox-session &
sleep 2

echo "Starting x11vnc..."
mkdir -p /home/user/.vnc
x11vnc -storepasswd "$VNC_PW" /home/user/.vnc/passwd 2>/dev/null
x11vnc -display :99 -forever -shared -rfbport 5901 -rfbauth /home/user/.vnc/passwd -bg -o /tmp/x11vnc.log 2>/dev/null
sleep 1

echo "Starting noVNC..."
NOVNC_DIR=$(find /usr -name "vnc.html" -path "*/novnc/*" -exec dirname {} \; 2>/dev/null | head -1)
[ -z "$NOVNC_DIR" ] && NOVNC_DIR=/usr/share/novnc
/usr/bin/websockify --web "$NOVNC_DIR" 8080 localhost:5901 &
sleep 1

su - user -c "/cloud-mount.sh" &

echo "READY"
wait
