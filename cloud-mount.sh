#!/bin/bash

CONFIG_FILE=/config/.config/rclone/rclone.conf
MOUNT_PATH=/config/cloud
SETUP_SCRIPT=/config/Desktop/rclone-setup.desktop

if [ -f "$CONFIG_FILE" ]; then
    REMOTE=$(head -1 "$CONFIG_FILE" | tr -d '[]')
    if [ -n "$REMOTE" ]; then
        mkdir -p "$MOUNT_PATH"
        rclone mount "$REMOTE":"$REMOTE" "$MOUNT_PATH" \
            --daemon \
            --allow-other \
            --dir-cache-time 10m \
            --vfs-cache-mode writes \
            --log-level ERROR
    fi
else
    cat > "$SETUP_SCRIPT" << 'EOF'
[Desktop Entry]
Type=Application
Name=Rclone Setup
Comment=Configure cloud storage (Google Drive, Dropbox, OneDrive)
Exec=xfce4-terminal -e "bash -c 'rclone config; echo --- Done ---; echo Press Enter to close; read'"
Icon=drive-harddisk
Terminal=false
Categories=Utility;
EOF
fi
