FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV VNC_PW=admin123
ENV DISPLAY=:99
ENV VNC_PORT=5901
ENV NOVNC_PORT=8080

RUN apt-get update && apt-get install -y --no-install-recommends \
    xvfb \
    x11vnc \
    openbox \
    xterm \
    firefox \
    python3 \
    python3-numpy \
    python3-websockify \
    novnc \
    nano \
    curl \
    wget \
    unzip \
    sudo \
    ca-certificates \
    git \
    htop \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://rclone.org/install.sh | bash

RUN useradd -m -s /bin/bash user && \
    echo "user:user" | chpasswd && \
    echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN NOVNC_DIR=$(find /usr -name "vnc.html" -path "*/novnc/*" -exec dirname {} \; 2>/dev/null | head -1) && \
    echo '<meta http-equiv="refresh" content="0;url=vnc.html?autoconnect=1&resize=scale&password='"$VNC_PW"'">' > "$NOVNC_DIR/index.html"

RUN mkdir -p /home/user/Desktop /home/user/cloud

COPY start.sh /start.sh
RUN chmod +x /start.sh

COPY cloud-mount.sh /cloud-mount.sh
RUN chmod +x /cloud-mount.sh

COPY install-extra.sh /home/user/Desktop/
RUN chmod +x /home/user/Desktop/install-extra.sh

COPY install-extra.desktop /home/user/Desktop/

RUN chown -R user:user /home/user

EXPOSE 8080

CMD ["/start.sh"]
