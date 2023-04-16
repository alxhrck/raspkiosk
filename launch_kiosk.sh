#!/usr/bin/env bash
set -eo pipefail

xset -dpms      # disable DPMS (Energy Star) features.
xset s off      # disable screen saver
xset s noblank  # don't blank the video device

unclutter &     # hides your cursor after inactivity

[[ -e /data/webkiosk/Default/Preferences ]] && {
  sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' /data/webkiosk/Default/Preferences
  sed -i 's/"exit_type":"Crashed"/"exit_type":"None"/' /data/webkiosk/Default/Preferences
}

if [ -L /data/webkiosk/SingletonCookie ]; then
  rm -rf /data/webkiosk/Singleton*
fi

openbox-session &
xterm -bg black &
/usr/bin/chromium-browser \
    --kiosk \
    --disable-touch-drag-drop \
    --disable-overlay-scrollbar \
    --window-position=0,0 \
    --disable-session-crashed-bubble \
    --disable-infobars \
    --disable-sync \
    --no-first-run \
    --no-sandbox \
    --user-data-dir='/opt/raspkiosk/data' \
    --show-component-extension-options \
    --disable-background-networking \
    --enable-remote-extensions \
    --enable-native-gpu-memory-buffers \
    --disable-quic \
    --enable-fast-unload \
    --enable-tcp-fast-open \
    --ignore-gpu-blacklist \
    --use-gl=desktop \
    --disable-gpu-compositing \
    --force-gpu-rasterization \
    --enable-zero-copy \
    'https://apps.k3s.hrck.net/grafana/d/7u_qyox4k/network-monitoring'
