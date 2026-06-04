FROM lscr.io/linuxserver/webtop:ubuntu-xfce

ENV TITLE=CloudDesktop
ENV PUID=1000
ENV PGID=1000
ENV CUSTOM_USER=user
ENV PASSWORD=admin123
ENV VNC_PW=admin123
ENV VNC_RESOLUTION=1366x768

RUN apt-get update && apt-get install -y --no-install-recommends \
    libreoffice-writer \
    libreoffice-calc \
    libreoffice-impress \
    firefox \
    chromium-browser \
    gedit \
    gimp \
    vlc \
    filezilla \
    thunderbird \
    htop \
    neofetch \
    rclone \
    python3-pip \
    git \
    curl \
    wget \
    unzip \
    zip \
    nano \
    sudo \
    && rm -rf /var/lib/apt/lists/*

RUN echo "alias ll='ls -alF'" >> /config/.bashrc && \
    echo "alias la='ls -A'" >> /config/.bashrc && \
    echo "alias l='ls -CF'" >> /config/.bashrc

EXPOSE 3000
