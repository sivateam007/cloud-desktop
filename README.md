# Cloud Desktop on Render (Free Tier)

Browser-based Linux desktop with pre-installed apps, hosted on Render's free tier.

## Pre-installed Apps

| App | Purpose |
|---|---|
| LibreOffice Writer | Word documents (.docx) |
| LibreOffice Calc | Excel spreadsheets (.xlsx) |
| LibreOffice Impress | PowerPoint presentations (.pptx) |
| Firefox | Web browser + Office Online access |
| Chromium | Backup browser |
| GIMP | Image editing |
| VLC | Media player |
| FileZilla | FTP/SFTP client |
| Thunderbird | Email client |
| Terminal | Full command-line access |
| Git + Python + Node | Development tools |

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

Render free tier has **no persistent storage**. All files outside `/config` reset on restart.

| Data | Persists? | Strategy |
|---|---|---|
| User files | ❌ | Use rclone to mount Google Drive/Dropbox |
| Installed apps | ❌ | Reinstall or update Dockerfile |
| Browser data | ✔️ | Use Firefox/Chrome sync |
| Desktop config | ✔️ | Saved in `/config` |

### Mount Cloud Storage with rclone

```bash
# First-time setup (follow prompts)
rclone config

# Mount Google Drive to ~/cloud
mkdir -p ~/cloud
rclone mount gdrive: ~/cloud --daemon
```

## Limitations (Render Free Tier)

- **512MB RAM** — lightweight use only (~200MB free after desktop loads)
- **0.1 CPU** — slow but usable for office tasks
- **No Windows EXEs** — Linux only (Wine not practical with 512MB)
- **Spins down after 15 min** — keepalive solves this
- **No persistent disk** — save files to cloud storage
- **No HTTPS on custom domain** — use `onrender.com` subdomain
