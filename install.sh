#!/bin/sh

INSTALL_PATH=/opt/raspkiosk

apt update
apt install -y xinit openbox chromium-browser xdotool unclutter
chmod +x $INSTALL_PATH/launch_kiosk.sh
