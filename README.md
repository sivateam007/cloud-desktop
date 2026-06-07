# Cloud Desktop on Render (Free Tier)

Ubuntu desktop in your browser — hosted on Render free tier.

## Features

- **XFCE-style desktop**: taskbar with start menu, desktop icons, file manager, right-click menu
- **Firefox**: pre-installed browser
- **LibreOffice**: Writer (Word), Calc (Excel), Impress (PPT) — pre-installed
- **Terminal**: full bash with sudo
- **File Manager**: browse files, drag-and-drop from browser
- **Install more apps**: double-click "Install Extra Apps" on desktop
- **Cloud storage**: rclone auto-mounts Google Drive/Dropbox/OneDrive

## Access

`https://your-app.onrender.com` → auto-connects. No login needed.

## Keepalive

cron-job.org → ping every 10 min to prevent spin-down.

## Install Extra Apps

| App | How |
|---|---|
| Chromium, GIMP, VLC, FileZilla, Thunderbird | Click "Install Extra Apps" on desktop |
| Any Linux package | `sudo apt-get install <package>` |

## Limitations

- 512MB RAM / 0.1 CPU — slow but usable
- Apps you install via terminal reset after restart
- No Windows EXEs
