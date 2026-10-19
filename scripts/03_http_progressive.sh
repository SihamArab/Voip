#!/usr/bin/env bash
# Lab 3.1 - Progressive download over HTTP with Apache and an HTML5 video tag.
# Input : video.mkv from 02_h264_encoding.sh. Needs sudo.
set -euo pipefail

sudo apt-get install -y apache2
sudo systemctl start apache2

# A browser plays H.264 in an MP4 container, so the stream is copied without re-encoding.
ffmpeg -y -i video.mkv -c copy video.mp4
sudo cp video.mkv video.mp4 /var/www/html/

sudo tee /var/www/html/video.html > /dev/null <<'HTML'
<!doctype html>
<html><body>
<video src="video.mp4" controls width="352"></video>
</body></html>
HTML

echo "Open http://localhost/video.html"
