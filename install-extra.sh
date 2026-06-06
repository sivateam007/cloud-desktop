#!/bin/bash
echo "==========================================="
echo "  CloudDesktop - Install Extra Apps"
echo "==========================================="
echo ""
echo "These installs last only for this session."
echo ""
echo "1) LibreOffice (PPT, Word, Excel) ~200MB"
echo "2) Chromium Browser ~150MB"
echo "3) GIMP Image Editor ~80MB"
echo "4) VLC Media Player ~40MB"
echo "5) FileZilla FTP Client ~5MB"
echo "6) Thunderbird Email ~50MB"
echo "7) Install ALL of the above"
echo "8) Install via custom apt command"
echo "0) Exit"
echo ""
read -p "Choose [0-8]: " choice

case $choice in
  1) sudo apt-get update && sudo apt-get install -y --no-install-recommends libreoffice-writer libreoffice-calc libreoffice-impress && sudo rm -rf /var/lib/apt/lists/* && echo "Done! Run: libreoffice" ;;
  2) sudo apt-get update && sudo apt-get install -y --no-install-recommends chromium-browser && sudo rm -rf /var/lib/apt/lists/* && echo "Done! Run: chromium-browser" ;;
  3) sudo apt-get update && sudo apt-get install -y --no-install-recommends gimp && sudo rm -rf /var/lib/apt/lists/* && echo "Done! Run: gimp" ;;
  4) sudo apt-get update && sudo apt-get install -y --no-install-recommends vlc && sudo rm -rf /var/lib/apt/lists/* && echo "Done! Run: vlc" ;;
  5) sudo apt-get update && sudo apt-get install -y --no-install-recommends filezilla && sudo rm -rf /var/lib/apt/lists/* && echo "Done! Run: filezilla" ;;
  6) sudo apt-get update && sudo apt-get install -y --no-install-recommends thunderbird && sudo rm -rf /var/lib/apt/lists/* && echo "Done! Run: thunderbird" ;;
  7) sudo apt-get update && sudo apt-get install -y --no-install-recommends libreoffice-writer libreoffice-calc libreoffice-impress chromium-browser gimp vlc filezilla thunderbird && sudo rm -rf /var/lib/apt/lists/* && echo "Done! All installed." ;;
  8) read -p "Enter apt package name: " cmd && sudo apt-get update && sudo apt-get install -y --no-install-recommends $cmd && sudo rm -rf /var/lib/apt/lists/* ;;
  0) exit 0 ;;
  *) echo "Invalid choice" ;;
esac
echo ""
read -p "Press Enter to close..."
