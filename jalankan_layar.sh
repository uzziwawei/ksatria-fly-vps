#!/bin/bash

# =====================================================================
# SCRIPT OTOMATIS PENYELARAS LAYAR DAN GAME KSATRIA ONLINE (KEMULATOR)
# =====================================================================

echo "=================================================="
echo "1. MEMBERSIHKAN SISA PROSES YANG MACET/BENTROK..."
echo "=================================================="
pkill -9 -f vnc
pkill -9 -f Xvfb
pkill -9 -f websockify
pkill -9 -f openbox
pkill -9 -f xfce4
pkill -9 -f java
sleep 2

echo "=================================================="
echo "2. MENGATUR DISPLAY UTAMA (:0)..."
echo "=================================================="
export DISPLAY=:0

echo "=================================================="
echo "3. MENYALAKAN FRAMEBUFFER VIRTUAL (1024x768)..."
echo "=================================================="
Xvfb :0 -screen 0 1024x768x16 > /tmp/xvfb.log 2>&1 &
sleep 2

echo "=================================================="
echo "4. MENYALAKAN WINDOW MANAGER (OPENBOX)..."
echo "=================================================="
openbox-session > /tmp/openbox.log 2>&1 &
sleep 2

echo "=================================================="
echo "5. MENYALAKAN SERVER VNC (PORT 5900)..."
echo "=================================================="
x11vnc -display :0 -nopw -listen localhost -forever -shared > /tmp/x11vnc.log 2>&1 &
sleep 2

echo "=================================================="
echo "6. MENYALAKAN JALUR WEBSOCKIFY (PORT 8080)..."
echo "=================================================="
websockify --web=/usr/share/novnc 8080 localhost:5900 > /tmp/websockify.log 2>&1 &
sleep 2

echo "=================================================="
echo "7. MELUNCURKAN KEMULATOR DENGAN GAME (res.jar)..."
echo "=================================================="

# Mendeteksi lokasi file kemulator.jar
IF_FOLDER_A="/workspaces/ksatria-fly-vps/kemulator.jar"
IF_FOLDER_B="./kemulator.jar"
 copy
if [ -f "$IF_FOLDER_A" ]; then
    echo "Menjalankan KEmulator dari folder proyek..."
    java -jar "$IF_FOLDER_A" /workspaces/ksatria-fly-vps/res.jar > /tmp/game.log 2>&1 &
elif [ -f "$IF_FOLDER_B" ]; then
    echo "Menjalankan KEmulator dari folder aktif saat ini..."
    java -jar "$IF_FOLDER_B" res.jar > /tmp/game.log 2>&1 &
else
    echo "EROR: kemulator.jar tidak ditemukan di folder mana pun!"
    echo "Pastikan kamu sudah mengunduh kemulator.jar terlebih dahulu."
fi

sleep 2
echo "=================================================="
echo "PROSES SELESAI DIAKTIFKAN SEMPURNA!"
echo "Silakan kembali ke tab browser noVNC kamu,"
echo "REFRESH halamannya, lalu klik tombol CONNECT biru!"
echo "=================================================="
```
eof

### Cara Menjalankan Script Ini:

Sekarang file tersebut sudah tersimpan di dalam folder proyek Codespaces kamu. Kamu hanya perlu melakukan dua langkah super gampang ini di terminal hitam Codespaces:

1. **Jalankan Script-nya:**
   Salin perintah di bawah ini, tempel ke terminal hitam Codespaces (atau kirim lewat obrolan kanan bawah), lalu tekan **Enter**:
   ```bash
   bash jalankan_layar.sh
