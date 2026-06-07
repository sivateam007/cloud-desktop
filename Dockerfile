FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV VNC_PW=admin123
ENV DISPLAY=:99
ENV NOVNC_PORT=8080

RUN apt-get update && apt-get install -y --no-install-recommends \
    xvfb x11vnc openbox \
    tint2 pcmanfm \
    xterm firefox \
    libreoffice-writer libreoffice-calc libreoffice-impress \
    python3 python3-numpy python3-websockify novnc \
    nano curl wget unzip sudo ca-certificates \
    git htop \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://rclone.org/install.sh | bash

RUN useradd -m -s /bin/bash user && \
    echo "user:user" | chpasswd && \
    echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN mkdir -p /home/user/Desktop /home/user/cloud \
    /home/user/.config/openbox \
    /home/user/.config/tint2 \
    /home/user/.config/pcmanfm/default \
    /root/.config/openbox

COPY menu.xml /home/user/.config/openbox/menu.xml
COPY tint2rc /home/user/.config/tint2/tint2rc
COPY pcmanfm.conf /home/user/.config/pcmanfm/default/pcmanfm.conf

RUN cp /home/user/.config/openbox/menu.xml /root/.config/openbox/menu.xml

RUN python3 <<'PYEOF'
width, height = 1280, 720
pixels = []
for y in range(height):
    for x in range(width):
        r = int(45 + (y / height) * 10)
        g = int(45 + (x / width) * 15)
        b = int(60 + (y / height) * 20)
        pixels.extend([r, g, b])
ppm = 'P6\n{} {}\n255\n'.format(width, height)
with open('/home/user/wallpaper.ppm', 'wb') as f:
    f.write(ppm.encode())
    f.write(bytes(pixels))
with open('/root/wallpaper.ppm', 'wb') as f:
    f.write(ppm.encode())
    f.write(bytes(pixels))
PYEOF

COPY start.sh /start.sh
RUN chmod +x /start.sh

COPY cloud-mount.sh /cloud-mount.sh
RUN chmod +x /cloud-mount.sh

COPY install-extra.sh /home/user/Desktop/
RUN chmod +x /home/user/Desktop/install-extra.sh

COPY install-extra.desktop /home/user/Desktop/

RUN NOVNC_DIR=$(find /usr -name "vnc.html" -path "*/novnc/*" -exec dirname {} \; 2>/dev/null | head -1) && \
    echo '<meta http-equiv="refresh" content="0;url=vnc.html?autoconnect=1&resize=scale&password='"$VNC_PW"'">' > "$NOVNC_DIR/index.html"

RUN chown -R user:user /home/user

EXPOSE 8080

CMD ["/start.sh"]
