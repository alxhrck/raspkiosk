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

/usr/bin/chromium-browser \
    --disable-background-networking \
    --disable-component-extensions-with-background-pages \
    --disable-domain-reliability \
    --disable-extensions \
    --disable-features=MediaRouter \
    --disable-sync \
    --disable-touch-drag-drop \
    --enable-logging=stderr \
    --enable-zero-copy \
    --kiosk \
    --log-level=0 \
    --no-first-run \
    --use-gl=desktop \
    --user-data-dir=$INSTALL_PATH/data \
    --window-position=0,0 \
    'https://apps.k3s.hrck.net/grafana/d/7u_qyox4k/network-monitoring'
