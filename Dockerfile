FROM lscr.io/linuxserver/webtop:ubuntu-xfce

ENV TITLE=CloudDesktop
ENV PUID=1000
ENV PGID=1000
ENV CUSTOM_USER=user
ENV PASSWORD=admin123
ENV VNC_PW=admin123
ENV VNC_RESOLUTION=1366x768
ENV CLOUD_MOUNT_PATH=/config/cloud

RUN apt-get update && apt-get install -y --no-install-recommends \
    firefox \
    nano \
    curl \
    wget \
    unzip \
    zip \
    sudo \
    fuse \
    && rm -rf /var/lib/apt/lists/* && \
    curl -fsSL https://rclone.org/install.sh | bash

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    python3-pip \
    htop \
    fastfetch \
    && rm -rf /var/lib/apt/lists/*

RUN echo "alias ll='ls -alF'" >> /config/.bashrc && \
    echo "alias la='ls -A'" >> /config/.bashrc && \
    echo "alias l='ls -CF'" >> /config/.bashrc

RUN mkdir -p /config/cloud /config/Desktop

COPY cloud-mount.sh /etc/cont-init.d/99-cloud-mount
RUN chmod +x /etc/cont-init.d/99-cloud-mount

COPY install-extra.sh /config/Desktop/install-extra.sh
RUN chmod +x /config/Desktop/install-extra.sh

COPY install-extra.desktop /config/Desktop/install-extra.desktop

EXPOSE 3000
