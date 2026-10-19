#!/usr/bin/env bash
# Lab 3.2 - Unicast RTSP/RTP streaming of a file with live555MediaServer.
# Usage : ./04_rtsp_unicast.sh server        run on the server
#         ./04_rtsp_unicast.sh client IP     run on a client
# For the capture, run Wireshark on the same machine with the filter  rtsp || rtp || rtcp
set -euo pipefail

case "${1:-}" in
  server)
    sudo apt-get install -y livemedia-utils
    mkdir -p media
    cp video.mkv media/
    cd media
    # Prints the RTSP URL it serves, and listens on the RTSP port it announces.
    live555MediaServer
    ;;
  client)
    ffplay "rtsp://${2:?server IP required}/video.mkv"
    ;;
  *)
    echo "usage: $0 server | client IP"; exit 1;;
esac
