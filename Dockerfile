FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENv VNC_PW=admin123
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
    sudo \
    ca-certificates \
    git \
    htop \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://rclone.org/install.sh | bash

RUN curl -fsSL https://github.com/novnc/noVNC/archive/refs/tags/v1.5.0.tar.gz | tar xz -C /tmp && \
    mkdir -p /usr/share/novnc && \
    cp -r /tmp/noVNC-1.5.0/* /usr/share/novnc/ && \
    rm -rf /tmp/noVNC-1.5.0

RUN useradd -m -s /bin/bash user && \
    echo "user:user" | chpasswd && \
    echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

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
