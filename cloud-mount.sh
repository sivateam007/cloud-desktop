#!/bin/bash

CONFIG_FILE=/home/user/.config/rclone/rclone.conf
MOUNT_PATH=/home/user/cloud

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
fi
