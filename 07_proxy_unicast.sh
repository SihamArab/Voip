#!/usr/bin/env bash
# Lab 5.1 - RTSP proxy unicast to unicast.
# The proxy keeps one RTSP/RTP connection with the camera and serves several clients.
# Usage : ./07_proxy_unicast.sh proxy CAMERA_IP
#         ./07_proxy_unicast.sh client PROXY_IP
set -euo pipefail

case "${1:-}" in
  proxy)
    live555ProxyServer "rtsp://${2:?camera IP required}:5554"
    ;;
  client)
    ffplay "rtsp://${2:?proxy IP required}:8554/proxyStream"
    ;;
  *)
    echo "usage: $0 proxy CAMERA_IP | client PROXY_IP"; exit 1;;
esac
