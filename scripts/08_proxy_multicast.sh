#!/usr/bin/env bash
# Lab 5.2 - Proxy from RTSP unicast to RTP multicast with VLC.
# Usage : ./08_proxy_multicast.sh proxy CAMERA_IP
#         ./08_proxy_multicast.sh client camera.sdp
set -euo pipefail

case "${1:-}" in
  proxy)
    sudo apt-get install -y vlc
    cvlc "rtsp://${2:?camera IP required}:5554" \
      --sout '#rtp{dst=239.255.42.42,port=1234,name=stream,sdp=file:///tmp/camera.sdp}'
    # Copy /tmp/camera.sdp to the clients. It describes the media, the multicast
    # address, the port and the payload type.
    ;;
  client)
    ffplay "${2:?sdp file required}"
    ;;
  *)
    echo "usage: $0 proxy CAMERA_IP | client camera.sdp"; exit 1;;
esac
