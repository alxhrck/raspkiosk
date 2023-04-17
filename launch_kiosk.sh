#!/usr/bin/env bash

INSTALL_PATH=/opt/raspkiosk

set -eo pipefail

xset -dpms      # disable DPMS (Energy Star) features.
xset s off      # disable screen saver
xset s noblank  # don't blank the video device

unclutter -idle 0.5 -root &     # hides your cursor after inactivity

[[ -e $INSTALL_PATH/data/Default/Preferences ]] && {
  sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' $INSTALL_PATH/data/Default/Preferences
  sed -i 's/"exit_type":"Crashed"/"exit_type":"None"/' $INSTALL_PATH/data/Default/Preferences
}

if [ -L $INSTALL_PATH/data/SingletonCookie ]; then
  rm -rf $INSTALL_PATH/data/Singleton*
fi

openbox-session &
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
    --user-data-dir='$INSTALL_PATH/data' \
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
