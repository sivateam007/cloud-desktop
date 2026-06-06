FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TITLE=CloudDesktop
ENV VNC_PW=admin123
ENV VNC_RESOLUTION=1280x720
ENV DISPLAY=:99

RUN apt-get update && apt-get install -y --no-install-recommends \
    xvfb \
    x11vnc \
    openbox \
    obconf \
    xorgxrdp \
    xterm \
    firefox \
    nano \
    curl \
    wget \
    unzip \
    sudo \
    ca-certificates \
    python3 \
    python3-numpy \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://rclone.org/install.sh | bash

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    htop \
    net-tools \
    && rm -rf /var/lib/apt/lists/*

RUN ln -sf /usr/bin/python3 /usr/bin/python

RUN mkdir -p /opt/novnc && \
    curl -fsSL https://github.com/novnc/noVNC/archive/refs/tags/v1.5.0.tar.gz | \
    tar xz -C /opt/novnc --strip-components=1 && \
    curl -fsSL https://github.com/novnc/websockify/archive/refs/tags/v0.12.0.tar.gz | \
    tar xz -C /opt/novnc/utils --strip-components=1

RUN useradd -m -s /bin/bash user && \
    echo "user:user" | chpasswd && \
    echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN echo "alias ll='ls -alF'" >> /home/user/.bashrc && \
    echo "alias la='ls -A'" >> /home/user/.bashrc

COPY start.sh /start.sh
RUN chmod +x /start.sh

COPY cloud-mount.sh /cloud-mount.sh
RUN chmod +x /cloud-mount.sh

RUN mkdir -p /home/user/Desktop
COPY install-extra.desktop /home/user/Desktop/
COPY install-extra.sh /home/user/Desktop/
RUN chmod +x /home/user/Desktop/install-extra.sh

RUN chown -R user:user /home/user

EXPOSE 8080

CMD ["/start.sh"]
