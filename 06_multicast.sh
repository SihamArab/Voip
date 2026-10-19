#!/usr/bin/env bash
# Lab 4 - Multicast video transmission on the group 239.255.42.42, port 1234.
# 239.0.0.0/8 is the administratively scoped multicast range.
# Usage : ./06_multicast.sh server       needs test.ts, an MPEG-2 transport stream
#         ./06_multicast.sh client       run it on several machines or in several terminals
set -euo pipefail

case "${1:-}" in
  server)
    mkdir -p media
    cp test.ts media/
    cd media
    testMPEG2TransportStreamer
    ;;
  client)
    ffplay rtp://@239.255.42.42:1234
    ;;
  *)
    echo "usage: $0 server | client"; exit 1;;
esac
# Compare the bandwidth with 1, 2 and 3 clients in gnome-system-monitor,
# constant for multicast, proportional to the number of clients for unicast.
