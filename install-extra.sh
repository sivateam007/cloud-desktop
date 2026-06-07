#!/bin/bash
echo "==========================================="
echo "  CloudDesktop - Install Extra Apps"
echo "==========================================="
echo ""
echo "1) Chromium Browser ~150MB"
echo "2) GIMP Image Editor ~80MB"
echo "3) VLC Media Player ~40MB"
echo "4) FileZilla FTP Client ~5MB"
echo "5) Thunderbird Email ~50MB"
echo "6) Install ALL of the above"
echo "7) Install via custom apt command"
echo "0) Exit"
echo ""
read -p "Choose [0-7]: " choice

case $choice in
  1) apt-get update && apt-get install -y --no-install-recommends chromium-browser && rm -rf /var/lib/apt/lists/* && echo "Done!" ;;
  2) apt-get update && apt-get install -y --no-install-recommends gimp && rm -rf /var/lib/apt/lists/* && echo "Done!" ;;
  3) apt-get update && apt-get install -y --no-install-recommends vlc && rm -rf /var/lib/apt/lists/* && echo "Done!" ;;
  4) apt-get update && apt-get install -y --no-install-recommends filezilla && rm -rf /var/lib/apt/lists/* && echo "Done!" ;;
  5) apt-get update && apt-get install -y --no-install-recommends thunderbird && rm -rf /var/lib/apt/lists/* && echo "Done!" ;;
  6) apt-get update && apt-get install -y --no-install-recommends chromium-browser gimp vlc filezilla thunderbird && rm -rf /var/lib/apt/lists/* && echo "Done!" ;;
  7) read -p "Enter apt package name: " cmd && apt-get update && apt-get install -y --no-install-recommends $cmd && rm -rf /var/lib/apt/lists/* ;;
  0) exit 0 ;;
  *) echo "Invalid choice" ;;
esac
echo ""
read -p "Press Enter to close..."
