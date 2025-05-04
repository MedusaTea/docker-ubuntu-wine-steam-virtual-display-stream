#!/bin/bash

# might need to set this outside script
#export HOST_IP=$(grep nameserver /etc/resolv.conf | awk '{print $2}')

export DISPLAY=:1

echo "[INFO] Starting virtual X display..."
Xvfb :1 -screen 0 1920x1080x24 &
sleep 2

wineboot --init

wget -O /tmp/steamsetup.exe https://cdn.cloudflare.steamstatic.com/client/installer/SteamSetup.exe && \
    wine /tmp/steamsetup.exe

export WINEPREFIX=/wineprefix
mkdir -p $WINEPREFIX && wineboot --init

rm -f /tmp/steamsetup.exe

winetricks -q steam

echo "[INFO] Launching Steam..."
wine "C:\\Program Files (x86)\\Steam\\steam.exe" &

sleep 10 # adjust depending on game load time

echo "[INFO] Starting ffmpeg stream..."
ffmpeg -video_size 1920x1080 -framerate 30 -f x11grab -i :1 \
  -c:v libx264 -preset ultrafast -tune zerolatency -b:v 2500k \
  -f flv rtmp://host.docker.internal/live/stream
  
  #-f flv rtmp://$HOST_IP/live/stream
#Note: host.docker.internal works on Docker Desktop for Windows/macOS.
# On WSL2 you may need to replace it with your host IP (see below).
