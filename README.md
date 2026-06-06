# Cloud Desktop on Render (Free Tier)

Browser-based Ubuntu desktop hosted on Render's free tier.

## Pre-installed

- Firefox web browser
- Terminal (bash)
- Git, Python
- x11vnc + noVNC (browser access)
- rclone (cloud storage mount)

## Install More Apps (one-click)

Double-click **Install Extra Apps** on the desktop to install:
LibreOffice (PPT/Word/Excel), Chromium, GIMP, VLC, FileZilla, Thunderbird.

Or in terminal: `sudo apt-get install <package>`

## Deploy

1. Push this repo to GitHub
2. Render Dashboard → New Web Service → connect repo
3. Language: **Docker**, Instance: **Free**
4. Deploy → wait ~5 min
5. Open `https://your-app.onrender.com`

**Password:** admin123

## Keepalive (prevent spin-down)

Create a free cron job at cron-job.org → ping every 10 min.

## Limitations

- 512MB RAM, 0.1 CPU — lightweight use only
- No Windows EXEs
- Apps installed during session are lost after restart
- Files saved in `/home/user/cloud` persist via rclone
