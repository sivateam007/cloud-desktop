#!/bin/bash

VNC_PORT=5900
NOVNC_PORT=8080

sudo -u user mkdir -p /home/user/.vnc

echo "$VNC_PW" | sudo -u user sh -c "x11vnc -storepasswd \$VNC_PW /home/user/.vnc/passwd" > /dev/null 2>&1

Xvfb :99 -screen 0 1280x720x16 &
sleep 1

export DISPLAY=:99
openbox-session &
sleep 1

x11vnc -display :99 -forever -shared -rfbport $VNC_PORT -rfbauth /home/user/.vnc/passwd -bg -o /tmp/x11vnc.log

python3 /opt/novnc/utils/websockify.py --web /opt/novnc $NOVNC_PORT localhost:$VNC_PORT --daemon

/cloud-mount.sh &

sleep 2

echo "======================================"
echo "  CloudDesktop is running!"
echo "  Access at: http://localhost:$NOVNC_PORT"
echo "======================================"

wait
