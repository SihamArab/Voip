#!/usr/bin/env bash
# Lab 1.1 - RGB to YUV 4:2:0 conversion and size comparison.
# Input : video.rgb, raw RGB24 frames, 352x288, provided by the course.
set -euo pipefail

W=352
H=288
FPS=30

ffmpeg -y -pix_fmt rgb24 -s ${W}x${H} -i video.rgb -pix_fmt yuv420p video.yuv

echo "--- file sizes"
du -b video.rgb video.yuv

# RGB24 uses 3 bytes per pixel, YUV 4:2:0 uses 1.5, so the YUV file is half the size.
rgb_bytes=$(stat -c %s video.rgb)
frames=$(( rgb_bytes / (W * H * 3) ))
echo "frames   : ${frames}"
echo "duration : $(awk "BEGIN {printf \"%.2f\", ${frames}/${FPS}}") s at ${FPS} fps"
