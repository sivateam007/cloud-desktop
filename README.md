# Cloud Desktop on Render (Free Tier)

Browser-based Linux desktop with pre-installed apps, hosted on Render's free tier.

## Pre-installed Apps

| App | Purpose |
|---|---|
| Firefox | Web browser + Office Online access |
| Terminal | Full command-line access |
| Git + Python | Development tools |
| rclone | Cloud storage auto-mount |
| Nano editor | File editing |

## Install Extra Apps (One-Click)

Double-click **"Install Extra Apps"** on the desktop to install:

| App | Size | Purpose |
|---|---|---|
| LibreOffice | ~200MB | PPT, Word, Excel |
| Chromium | ~150MB | Backup browser |
| GIMP | ~80MB | Image editor |
| VLC | ~40MB | Media player |
| FileZilla | ~5MB | FTP/SFTP |
| VS Code | ~100MB | Code editor |
| Thunderbird | ~50MB | Email client |

> **Note:** Installed apps last only for the current session. After a Render restart, re-install using the same shortcut. To make permanent, add to `Dockerfile`.

## How to Deploy

### 1. Push to GitHub

```bash
git init
git add .
git commit -m "Initial commit - Cloud Desktop"
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
git push -u origin main
```

### 2. Deploy on Render

1. Go to [render.com](https://render.com) and sign in
2. Click **New** → **Web Service**
3. Connect your GitHub repo
4. Set **Language** to `Docker`
5. Choose **Free** instance type
6. Click **Deploy**
7. Wait ~5-10 minutes for build to complete

### 3. Set Up Keepalive

Render spins down free services after 15 minutes of inactivity. To keep it running:

1. Go to [cron-job.org](https://cron-job.org) (free)
2. Create account → **Create Cronjob**
3. Set URL: `https://your-app-name.onrender.com`
4. Set interval: **Every 10 minutes**
5. Save

## How to Access

Open `https://your-app-name.onrender.com` in any browser.

**Login:**
- Username: `user`
- Password: `admin123`

## How to Use Office Documents

**Option A — LibreOffice (offline):**
- Open LibreOffice from the desktop menu
- Create/edit pptx, xlsx, docx files
- Save to local storage

**Option B — Microsoft Office Online (better compatibility):**
- Open Firefox from the desktop
- Go to [office.com](https://office.com)
- Sign in with your Microsoft account (free)
- Full PowerPoint, Word, Excel in browser

## How to Install More Apps

**During a session (terminal):**
```bash
sudo apt-get update
sudo apt-get install <package-name>
```
Works for that session only — reinstalls after restart.

**Permanently (in Dockerfile):**
1. Edit `Dockerfile` → add app to the `apt-get install` list
2. Commit and push to GitHub
3. Render auto-rebuilds

## Persistence

Render free tier has **no persistent disk**. But `/config` folder **is preserved** across restarts. We use this to persist your cloud storage connection.

| Data | Persists? | Strategy |
|---|---|---|
| User files | ✅ via cloud mount | rclone auto-mounts Google Drive/Dropbox/OneDrive |
| Cloud config | ✅ | Saved in `/config/.config/rclone/rclone.conf` |
| Installed apps | ❌ | Reinstall or update Dockerfile |
| Browser data | ✅ | Use Firefox/Chrome sync (or save to cloud mount) |
| Desktop config | ✅ | Saved in `/config` |

### External Cloud Storage (Auto-Mount)

The desktop auto-mounts your cloud storage on every session via **rclone**.

**First-time setup** (do once — survives restarts):

1. Open **Terminal** from the desktop menu
2. Run:
   ```bash
   rclone config
   ```
3. Follow prompts to connect your cloud service:
   - Type `n` → name it (e.g. `gdrive`)
   - Choose provider number (Google Drive=13, Dropbox=8, OneDrive=30)
   - Follow OAuth link to authorize
   - Done
4. **Restart the desktop** (or reboot from the menu)
5. Your cloud files appear in the **cloud** folder on the desktop

**Supported providers:** Google Drive (15GB free), Dropbox (2GB free), OneDrive (5GB free), and [50+ others](https://rclone.org/overview/).

**Your files survive all restarts, redeploys, and spin-ups.**

## Limitations (Render Free Tier)

- **512MB RAM** — lightweight use only (~200MB free after desktop loads)
- **0.1 CPU** — slow but usable for office tasks
- **No Windows EXEs** — Linux only (Wine not practical with 512MB)
- **Spins down after 15 min** — keepalive solves this
- **No persistent disk** — save files to cloud storage
- **No HTTPS on custom domain** — use `onrender.com` subdomain
