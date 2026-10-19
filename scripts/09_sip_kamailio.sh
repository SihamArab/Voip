#!/usr/bin/env bash
# Lab 6 - SIP server with Kamailio, registrar and proxy functions.
# Clients : Twinkle on Linux as user 100, Linphone on Android as user 200.
# Needs sudo. Usage : ./09_sip_kamailio.sh install | check
set -euo pipefail

case "${1:-}" in
  install)
    sudo apt-get install -y kamailio twinkle
    sudo systemctl start kamailio
    ;;
  check)
    # Kamailio must listen on UDP and TCP port 5060.
    sudo netstat -apn --inet | grep kamailio
    ;;
  *)
    echo "usage: $0 install | check"; exit 1;;
esac

cat <<'TXT'

Client profiles, transport UDP, proxy address set to the Kamailio server :
  Twinkle  : user 100. If Twinkle runs on the same computer as Kamailio, use another
             SIP port in its network settings, for example 5070, to avoid a conflict.
  Linphone : user 200.

Test : call from Twinkle to Linphone, and in Wireshark with the filter  sip
find the INVITE, 100 Trying, 180 Ringing, 200 OK and ACK messages.
If your Kamailio configuration enables authentication, the users must be created first.
TXT
