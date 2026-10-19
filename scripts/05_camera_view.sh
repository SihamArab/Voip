#!/usr/bin/env bash
# Lab 3.3 - View a smartphone used as a surveillance camera.
# Setup : the phone runs the Android app "RTSP Camera Server" and shares its connection
#         as a Wi-Fi hotspot. The PC joins that Wi-Fi network.
# Usage : ./05_camera_view.sh PHONE_IP
set -euo pipefail

ffplay "rtsp://${1:?phone IP required}:5554"
